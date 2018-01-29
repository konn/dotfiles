#!/usr/bin/env bash
ln -sf $(pwd)/.zshrc                  $HOME/.zshrc  
ln -sf $(pwd)/.zshrc.d                $HOME/.zshrc.d

mkdir -p $HOME/.cabal
ln -sf $(pwd)/.cabal/config           $HOME/.cabal
ln -sf $(pwd)/.cabal/config.platform  $HOME/.cabal
