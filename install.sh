#!/usr/bin/env bash
ln -sf $(pwd)/.zshrc                  $HOME/.zshrc  
ln -sf $(pwd)/.zshrc.d                $HOME/.zshrc.d

mkdir -p $HOME/.cabal
ln -sf $(pwd)/.cabal/config           $HOME/.cabal
ln -sf $(pwd)/.cabal/config.platform  $HOME/.cabal

EMACS_HOME=$HOME/.emacs.d
MY_EMACS=$(pwd)/.emacs.d
mkdir -p ${EMACS_HOME}
for i in ${MY_EMACS}/**/*; do
    targ=$(echo "${i}" | awk -F"${MY_EMACS}" '{print $NF}')
    if [ -f "${i}" ] ; then
       mkdir -p "${EMACS_HOME}$(dirname ${targ})"
       ln -sf ${MY_EMACS}${targ} ${EMACS_HOME}${targ}
    fi
done
