#!/bin/bash

DOTFILES=$HOME/Documents/projects/dotfiles

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
:<< END
echo -e "\\n\\ninstalling to ~/.config"
echo "=============================="
if [ ! -d "$HOME/.config" ]; then
    echo "Creating ~/.config"
    mkdir -p "$HOME/.config"
fi

config_files=$( find "$DOTFILES/config" -d 1 2>/dev/null )
for config in $config_files; do
    target="$HOME/.config/$( basename "$config" )"
    if [ -e "$target" ]; then
        echo "~${target#$HOME} already exists... Skipping."
    else
        echo "Creating symlink for $config"
        ln -s "$config" "$target"
    fi
done


echo -e "\\n\\nCreating vim symlinks"
echo "=============================="
VIMFILES=("$HOME/.vimrc:$DOTFILES/vim/init.vim" )

for file in "${VIMFILES[@]}"; do
    KEY=${file%%:*}
    VALUE=${file#*:}
    if [ -e "${KEY}" ]; then
        # echo "${KEY} already exists... skipping."

   	echo "~${KEY} already exists... Deleting"
	rm "$KEY"
        ln -s "${VALUE}" "${KEY}"
    else
        echo "Creating symlink for $KEY"
        ln -s "${VALUE}" "${KEY}"
    fi
done
END
