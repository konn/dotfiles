#!/usr/bin/env zsh

which cargo || (curl https://sh.rustup.rs -sSf | sh)
PATH=$HOME/.cargo/bin:$PATH

pushd install-dotfiles
cargo run --release
