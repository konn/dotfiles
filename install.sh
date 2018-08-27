#!/usr/bin/env zsh

which cargo || (curl https://sh.rustup.rs -sSf | sh)
PATH=$HOME/.cargo/bin:$PATH

pushd dotfile-installer
cargo run --release
