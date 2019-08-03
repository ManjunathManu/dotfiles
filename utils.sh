#!/bin/bash

set +e
set -o noglob

#
# Set Colors
#

bold="\e[1m"
dim="\e[2m"
underline="\e[4m"
blink="\e[5m"
reset="\e[0m"
red="\e[31m"
green="\e[32m"
blue="\e[34m"


#
# Common Output Styles
#

h1() {
	printf "\n${bold}${underline}%s${reset}\n" "$(echo "$@" | sed '/./,$!d')"
}
h2() {
	printf "\n${bold}%s${reset}\n" "$(echo "$@" | sed '/./,$!d')"
}
info() {
	printf "\n${dim}➜ %s${reset}\n" "$(echo "$@" | sed '/./,$!d')"
}
success() {
	printf "\n${green}✔ %s${reset}\n" "$(echo "$@" | sed '/./,$!d')"
}
error() {
	printf "${red}${bold}✖ %s${reset}\n" "$(echo "$@" | sed '/./,$!d')"
}
warnError() {
	printf "${red}✖ %s${reset}\n" "$(echo "$@" | sed '/./,$!d')"
}
warnNotice() {
	printf "${blue}Warning:%s${reset}\n" "$(echo "$@" | sed '/./,$!d')"
}
note() {
	printf "\n${bold}${blue}Note:${reset} ${blue}%s${reset}\n" "$(echo "$@" | sed '/./,$!d')"
}
newLine() {
  printf "\n"
}

# Runs the specified command and logs it appropriately.
#   $1 = command
#   $2 = (optional) error message
#   $3 = (optional) success message
#   $4 = (optional) global variable to assign the output to
runCommand() {
	command="$1"
	info "$1"
	output="$(eval $command 2>&1)"
	ret_code=$?

	if [ $ret_code != 0 ]; then
		warnError "$output"
		if [ ! -z "$2" ]; then
			error "$2"
		fi
		exit $ret_code
	fi
	if [ ! -z "$3" ]; then
		success "$3"
	fi
	if [ ! -z "$4" ]; then
		eval "$4='$output'"
	fi
}

# Check whether a particular environment variable exist or not
# S1 = Variable to be checked
# $2 = Value of the variable
checkVariableExistence() {
  info "$1"
  if [ -z "$2" ]; then
    error "Please set the \"$1\" variable"
    exit 1
  fi
}
