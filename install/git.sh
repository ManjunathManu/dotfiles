#!/usr/bin/env bash

source utils.sh

Note="Using this helper will store your passwords unencrypted on disk, protected only by filesystem permissions.
If this is not an acceptable security tradeoff, try git-credential-cache[1], or
find a helper that integrates with secure storage provided by your operating system.";

read -rn 1 -p "Do you want to globally configure git? [y/n]: " configGit

if [[ $configGit =~ ^([Yy])$ ]]; then
  newLine

  # Personal/machine settings go to ~/.gitconfig.local (included by the
  # tracked git/gitconfig.symlink), never into the repo: ~/.gitconfig is a
  # symlink, so `git config --global` would write into the tracked file.
  LOCAL="$HOME/.gitconfig.local"
  touch "$LOCAL" && chmod 600 "$LOCAL"

  defaultName=$( git config --file "$LOCAL" user.name )
  defaultEmail=$( git config --file "$LOCAL" user.email )
  defaultGithub=$( git config --file "$LOCAL" github.user )
  defaultGitEditor=$( git config --get core.editor )

  read -rp "Name [$defaultName] " name
  read -rp "Email [$defaultEmail] " email
  read -rp "Github username [$defaultGithub] " github
  read -rp "Default Git Editor [$defaultGitEditor] " editor

  git config --file "$LOCAL" user.name "${name:-$defaultName}"
  git config --file "$LOCAL" user.email "${email:-$defaultEmail}"
  git config --file "$LOCAL" github.user "${github:-$defaultGithub}"
  git config --file "$LOCAL" core.editor "${editor:-$defaultGitEditor}"

  # Different email for personal repos, chosen by folder (includeIf gitdir).
  # git config appends the section at the end, after [user], so it wins there.
  PERSONAL_DIR="$HOME/workspace/source-code/personal/"
  defaultPersonal=$( git config --file "$HOME/.gitconfig.personal" user.email 2>/dev/null )
  read -rp "Email for repos under ${PERSONAL_DIR/#$HOME/\~} (blank to skip) [$defaultPersonal] " personal
  personal="${personal:-$defaultPersonal}"
  if [ -n "$personal" ]; then
    git config --file "$HOME/.gitconfig.personal" user.email "$personal"
    chmod 600 "$HOME/.gitconfig.personal"
    git config --file "$LOCAL" "includeIf.gitdir:$PERSONAL_DIR.path" "$HOME/.gitconfig.personal"
  fi

  if [[ "$( uname )" == "Darwin" ]]; then
    git config --file "$LOCAL" credential.helper "osxkeychain"
  else
    note "$Note";
    newLine

    note "The point of this helper is to reduce the number of times you must type your username or password."
    newLine

    read -rn 1 -p "Save user and password to an unencrypted file to avoid writing? [y/n]: " save

    if [[ $save =~ ^([Yy])$ ]]; then
      git config --file "$LOCAL" credential.helper "store"
    else
      git config --file "$LOCAL" credential.helper "cache --timeout 3600"
    fi
  fi
fi
