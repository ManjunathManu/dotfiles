#!/bin/bash

source utils.sh

# DOTFILES=$HOME/workspace/source-code/personal/dotfiles
DOTFILES=$(pwd)

warnNotice "This will delete all your existing dotfiles, Please take a backup if you want";
printf "Do you want override existing dotfile? [y/n]: "
read -r override

find -H "$DOTFILES" -maxdepth 3 -name '*.symlink' | while IFS= read -r file; do
  # Extract the directory name to check if it should go in .config
  dir_name=$(dirname "$file" | xargs basename)
  base_name=$(basename "$file" '.symlink')

  # Special handling for .config subdirectories
  if [[ "$dir_name" == "starship" ]] || [[ "$dir_name" == "lazygit" ]] || \
     [[ "$dir_name" == "nvim" ]] || [[ "$dir_name" == "alacritty" ]] || \
     [[ "$dir_name" == "wezterm" ]] || [[ "$dir_name" == "kitty" ]] || \
     [[ "$dir_name" == "bat" ]] || [[ "$dir_name" == "mise" ]]; then
    # Create .config subdirectory if it doesn't exist
    config_dir="$HOME/.config/$dir_name"
    mkdir -p "$config_dir"
    target="$config_dir/$base_name"
  else
    # Regular dotfile in home directory
    target="$HOME/.$base_name"
  fi

  if [ -e "$target" ]; then
    if [[ $override =~ ^([Yy])$ ]]; then
      info "~${target#$HOME} already exists... Deleting"
      rm -rf "$target"
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
