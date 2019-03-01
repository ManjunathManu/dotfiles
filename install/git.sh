#!/usr/bin/env bash

read -rn 1 -p "Do you want to globally configure git? (y/N) " configGit
if [[ $configGit =~ ^([Yy])$ ]]; then
echo
printf "Setting up Git...\\n\\n"

defaultName=$( git config --global user.name )
defaultEmail=$( git config --global user.email )
defaultGithub=$( git config --global github.user )
defaultGitEditor=$( git config --global core.editor )

read -rp "Name [$defaultName] " name
read -rp "Email [$defaultEmail] " email
read -rp "Github username [$defaultGithub] " github
read -rp "Default Git Editor [$defaultGitEditor] " editor

git config --global user.name "${name:-$defaultName}"
git config --global user.email "${email:-$defaultEmail}"
git config --global github.user "${github:-$defaultGithub}"
git config --global core.editor "${editor:-$defaultGitEditor}"

if [[ "$( uname )" == "Darwin" ]]; then
    git config --global credential.helper "osxkeychain"
else
    read -rn 1 -p "Save user and password to an unencrypted file to avoid writing? [y/N] " save
    if [[ $save =~ ^([Yy])$ ]]; then
        git config --global credential.helper "store"
    else
        git config --global credential.helper "cache --timeout 3600"
    fi
fi
fi
