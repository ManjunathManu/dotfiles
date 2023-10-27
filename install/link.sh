#!/bin/bash

source utils.sh

# DOTFILES=$HOME/workspace/source-code/personal/dotfiles
DOTFILES=$(pwd)

linkables=$( find -H "$DOTFILES" -maxdepth 3 -name '*.symlink' )

warnNotice "This will delete all your existing dotfiles, Please take a backup if you want";
read -rn 1 -p "Do you want override existing dotfile? [y/n]: " override

for file in $linkables ; do
  target="$HOME/.$( basename "$file" '.symlink' )"
  if [ -e "$target" ]; then
    if [[ $override =~ ^([Yy])$ ]]; then
      info "~${target#$HOME} already exists... Deleting"
      rm "$target"
      info "Creating symlink for $file"
      ln -s "$file" "$target"
    else
      info "~${target#$HOME} already exists... Skipping."
    fi
  else
    info "Creating symlink for $file"
    ln -s "$file" "$target"
  fi
done
