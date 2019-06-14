#!/bin/bash

DOTFILES=$HOME/workspace/source-code/personal/dotfiles

echo -e "\\nCreating symlinks"
echo "=============================="
linkables=$( find -H "$DOTFILES" -maxdepth 3 -name '*.symlink' )
for file in $linkables ; do
  target="$HOME/.$( basename "$file" '.symlink' )"
  echo "$target"
  if [ -e "$target" ]; then
    # echo "~${target#$HOME} already exists... Skipping."
    echo "~${target#$HOME} already exists... Deleting"
    rm "$target"
    echo "Creating symlink for $file"
    ln -s "$file" "$target"
  else
    echo "Creating symlink for $file"
    ln -s "$file" "$target"
  fi
done
echo "=============================="
