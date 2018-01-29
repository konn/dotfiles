ZSH_HOME=$HOME/.zsh.d
ZSH_SHARE=${ZSH_HOME}/share

FPATH=/usr/local/share/zsh/functions:${FPATH}
FPATH=/usr/local/share/zsh-completions:${FPATH}
FPATH=${ZSH_HOME}/functions:${FPATH}

# Load Configuration Files
function loadconf() {
        lib=${1:?"You have to specify a library file"}
        if [ -f "${ZSH_HOME}/$lib" ];then
                . "${ZSH_HOME}/$lib"
        fi
}

function run_script() {
    loadconf scripts/${1}
}

# Load startup config files sits in site-start.d
for lib in ${ZSH_HOME}/site-start.d/*.zsh; do
    . $lib;
done

# Compile .zshrc if updated
if [ ~/.zshrc -nt ~/.zshrc.zwc ]; then
  zcompile ~/.zshrc
fi
