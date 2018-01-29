#!/usr/bin/env bash

# Overlaying existing conf directories
overlays=(.emacs.d .stack .cabal .zshrc.d)
for dir_name in ${overlays}; do
  TARGET=$HOME/${dir_name}
  MINE=$(pwd)/${dir_name}
  mkdir -p ${TARGET}
  for i in ${MINE}/**/*; do
      targ=$(echo "${i}" | awk -F"${MINE}" '{print $NF}')
      if [ -f "${i}" ] ; then
         mkdir -p "${TARGET}$(dirname ${targ})"
         ln -sf ${MINE}${targ} ${TARGET}${targ}
      fi
  done
done

# Single dot files
dots=(.gitattributes_global .gitconfig .gitignore_global)
dots=($dots .latexmkrc .ghci .inputrc)
dots=($dots .irbrc .languagetool.cfg .nethackrc .profile)
dots=($dots .stylish-haskell.yaml)
dots=($dots .zshrc)
for dot in ${dots}; do
  ln -sf "$(pwd)/${dot}" "${HOME}/${dot}"
done
