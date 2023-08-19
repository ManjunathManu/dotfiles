#!/usr/bin/env bash

source utils.sh

Note="Using this helper will store your passwords unencrypted on disk, protected only by filesystem permissions.
If this is not an acceptable security tradeoff, try git-credential-cache[1], or
find a helper that integrates with secure storage provided by your operating system.";

read -rn 1 -p "Do you want to globally configure git? [y/n]: " configGit

if [[ $configGit =~ ^([Yy])$ ]]; then
  newLine

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
    note "$Note";
    newLine

    note "The point of this helper is to reduce the number of times you must type your username or password."
    newLine

    read -rn 1 -p "Save user and password to an unencrypted file to avoid writing? [y/n]: " save

    if [[ $save =~ ^([Yy])$ ]]; then
      git config --global credential.helper "store"
    else
      git config --global credential.helper "cache --timeout 3600"
    fi
  fi
fi
