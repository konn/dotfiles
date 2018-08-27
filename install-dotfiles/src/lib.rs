#[macro_use]
extern crate serde_derive;

extern crate glob;
extern crate itertools;
extern crate serde_yaml;

use glob::Pattern;
use itertools::Itertools;
use std::collections::HashMap;
use std::fs;
use std::io;
use std::io::Write;
use std::os::unix;
use std::path::{Path, PathBuf};

#[derive(Debug)]
pub enum Error {
    IOError(io::Error),
    SerdeYamlError(serde_yaml::Error),
    InvalidPath(PathBuf),
    PatternError(glob::PatternError),
    NoRootFound,
    SomeError(String),
    FileAlreadyExists(PathBuf),
}

use Error::*;

impl From<io::Error> for Error {
    fn from(err: io::Error) -> Self {
        IOError(err)
    }
}

impl From<serde_yaml::Error> for Error {
    fn from(err: serde_yaml::Error) -> Self {
        SerdeYamlError(err)
    }
}

impl From<glob::PatternError> for Error {
    fn from(err: glob::PatternError) -> Self {
        PatternError(err)
    }
}

#[derive(Debug, PartialEq, Serialize, Deserialize)]
pub struct Group {
    pub group: String,
    pub from: PathBuf,
    pub dest: PathBuf,
    pub exclude: Option<Vec<PathBuf>>,
    pub symlinks: Vec<PathBuf>,
}

impl Group {
    pub fn new(
        group: &str,
        from: PathBuf,
        dest: PathBuf,
        exclude: Option<Vec<PathBuf>>,
        symlinks: Vec<PathBuf>,
    ) -> Group {
        Group {
            group: group.to_string(),
            from,
            dest,
            exclude,
            symlinks,
        }
    }
}

#[derive(Debug, PartialEq, Serialize, Deserialize)]
pub struct Config {
    exclude: Vec<PathBuf>,
    dotfiles: Vec<Group>,
    root: Option<PathBuf>,
}

pub type Result<T> = std::result::Result<T, Error>;

fn is_unsafe(path: &PathBuf) -> bool {
    path.components().any(|a| a.as_os_str() == "..")
}

fn is_invalid_source(path: &PathBuf) -> bool {
    path.is_absolute() || is_unsafe(path)
}

impl Config {
    pub fn empty() -> Config {
        Config {
            exclude: vec![],
            dotfiles: Vec::new(),
            root: None,
        }
    }

    fn validate(&mut self) -> Result<()> {
        let cwd = match self.root {
            None => std::env::current_dir()?,
            Some(ref a) => fs::canonicalize(decode_path(a).to_path_buf())?,
        };
        if let Some(invalid_path) = self.exclude.iter().find(|a| is_unsafe(a)) {
            return Err(InvalidPath(invalid_path.to_path_buf()));
        };
        for pat in self.exclude.iter_mut() {
            *pat = if pat.is_absolute() {
                cwd.join(&pat.strip_prefix("/").unwrap())
            } else {
                cwd.join("**").join(&pat)
            }
        }
        for Group {
            ref mut from,
            ref mut dest,
            exclude,
            symlinks,
            ..
        } in self.dotfiles.iter_mut()
        {
            if is_invalid_source(from) {
                return Err(InvalidPath(from.to_path_buf()));
            }

            if let Some(invalid_path) = exclude
                .iter()
                .flat_map(|a| a)
                .chain(symlinks.iter().filter(|a| a.is_absolute()))
                .find(|a| is_unsafe(a))
            {
                return Err(InvalidPath(invalid_path.to_path_buf()));
            }
            *from = fs::canonicalize(cwd.join(&from))?;
            *dest = decode_path(dest);

            for exc_pat in exclude.iter_mut().flat_map(|a| a.iter_mut()) {
                *exc_pat = from.to_path_buf().join(&exc_pat);
            }
        }
        self.root = Some(cwd);
        Ok(())
    }

    pub fn parse_config<P: AsRef<Path>>(path: P) -> Result<Config> {
        let src = fs::read_to_string(path)?;
        let mut answer: Config = serde_yaml::from_str(&src)?;
        answer.validate()?;
        Ok(answer)
    }

    pub fn run(&self) -> Result<()> {
        let ref global_excludes = self.exclude;
        for dot in &self.dotfiles {
            let excludes: Vec<_> = global_excludes
                .iter()
                .chain(dot.exclude.iter().flat_map(|a| a.iter()))
                .filter_map(|p| {
                    let s = p.to_str().unwrap();
                    if let Ok(pat) = Pattern::new(s) {
                        if let Ok(children) = Pattern::new(&format!("{}/**", s)) {
                            Some(vec![pat, children])
                        } else {
                            None
                        }
                    } else {
                        None
                    }
                })
                .flat_map(|a| a.into_iter())
                .collect();
            for sym in &dot.symlinks {
                for fp in glob::glob(dot.from.join(&sym).to_str().unwrap())?
                    .map(|a| a.unwrap())
                    .filter(|a| !excludes.iter().any(|p| p.matches_path(a)))
                {
                    let fp = fs::canonicalize(fp).unwrap();
                    let target = dot.dest.join(fp.strip_prefix(&dot.from).unwrap());
                    if target.exists() {
                        resolve_conflict(true, &excludes, fp, target)?;
                    } else {
                        unix::fs::symlink(fp, target)?;
                    }
                }
            }
        }
        Ok(())
    }
}

#[derive(Debug, Clone, PartialEq, Eq)]
enum ProcDupe {
    Skip,
    Overwrite,
    Copy,
}

pub fn decode_path(path: &Path) -> PathBuf {
    let home = std::env::home_dir().unwrap();
    match path.strip_prefix("~") {
        Ok(a) => home.join(a),
        Err(_) => PathBuf::from(path),
    }
}

fn read_bool(msg: String) -> bool {
    let seed: [(char, bool); 2] = [('y', true), ('n', false)];
    *prompt(msg, &true, &seed.iter().cloned().collect())
}

fn prompt<'a, T>(msg: String, def: &'a T, dic: &'a HashMap<char, T>) -> &'a T
where
    T: PartialEq,
{
    let labels = dic
        .iter()
        .map(|(c, t)| {
            if t == def {
                c.to_ascii_uppercase()
            } else {
                c.to_ascii_lowercase()
            }
        })
        .join("");
    println!("{}", msg);
    print!("[{}]: ", labels);
    io::stdout().flush().unwrap();

    loop {
        let mut input = String::new();
        if let Ok(_) = io::stdin().read_line(&mut input) {
            if input.trim().is_empty() {
                return def;
            } else if let Some(t) = dic.get(&input.chars().next().unwrap()) {
                return t;
            }
        }
        print!("Please enter {}: ", labels);
        io::stdout().flush().unwrap();
    }
}

fn resolve_conflict(
    do_symlink: bool,
    excludes: &Vec<Pattern>,
    fp: PathBuf,
    target: PathBuf,
) -> Result<()> {
    if target.canonicalize().unwrap() != fp {
        if target.symlink_metadata()?.file_type().is_symlink() {
            let msg = format!("Symlink {:?} already exists. override?", target);
            let to_overwrite = read_bool(msg);
            if to_overwrite {
                fs::remove_file(target)?;
            } else {
                println!("Skipping: {:?}", target);
            }
        } else if target.is_file() {
            let msg = format!(
                "A file {:?} already exists. Skip, overwrite, or copy?",
                target
            );
            use ProcDupe::*;
            let alternatives = [('s', Skip), ('o', Overwrite), ('c', Copy)]
                .iter()
                .cloned()
                .collect();
            let answer = prompt(msg, &Skip, &alternatives);
            if let Skip = answer {
                println!("Skipping: {:?} ", target);
            } else {
                if let Copy = answer {
                    println!("Copying {:?} to {:?}", fp, target);
                    fs::remove_file(&fp)?;
                    fs::rename(&target, &fp)?;
                }
                fs::remove_file(&target)?;
                if do_symlink {
                    println!("Symlinking {:?} to {:?}", fp, target);
                    unix::fs::symlink(fp, target)?;
                }
            }
        } else if target.is_dir() {
            if read_bool(format!("Directory {:?} already exists. Merge?", target)) {
                let new_targs: Vec<PathBuf> = target
                    .read_dir()?
                    .map(|a| a.unwrap().path())
                    .filter(|a| excludes.iter().any(|pat| pat.matches_path(a)))
                    .collect();
                if new_targs.is_empty() {
                    if read_bool(format!("Directory {:?} is empty. Override?", target)) {
                        fs::remove_dir(&target)?;
                        unix::fs::symlink(&fp, &target)?;
                    }
                } else {
                    println!("The directory is non-empty. Proceed to merging.");
                    for ref entry in new_targs {
                        let base_name = &entry.strip_prefix(&target).unwrap();
                        let new_fp = fp.join(base_name);
                        if new_fp.exists() {
                            resolve_conflict(false, excludes, new_fp, entry.to_path_buf())?;
                        } else {
                            if read_bool(format!("File {:?} doesn't exist. Copy?", new_fp)) {
                                fs::create_dir_all(new_fp.parent().unwrap())?;
                                let _ = fs::copy(&entry, new_fp)?;
                            }
                        }
                    }
                }
                if do_symlink {
                    fs::remove_dir_all(&target)?;
                    unix::fs::symlink(&fp, &target)?;
                }
            } else {
                println!("Skipping: {:?} ", target);
            }
        }
    }
    Ok(())
}
