extern crate install_dotfiles;
use install_dotfiles::*;

fn main() {
    Config::parse_config("config.yaml").unwrap().run().unwrap();
}
