#!/usr/bin/env zsh

# Overlaying existing conf directories
overlays=(.emacs.d .stack .cabal)
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
dots=(.ghci .gitattributes_global .gitconfig .gitignore_global)
dots=($dots .git_template .inputrc .irbrc .languagetool.cfg .latexmkrc)
dots=($dots .nethackrc .profile .stylish-haskell.yaml)
dots=($dots .zsh.d .zshrc)
for dot in ${dots}; do
  ln -sf "$(pwd)/${dot}" "${HOME}/${dot}"
done
