#!/bin/bash
# shellcheck disable=SC2034  # palette variables are used by scripts that source this file

set +e
set -o noglob

#
# Set Colors
#

bold="\e[1m"
# Color/style palette for scripts that source this file (some unused here)
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

typeExists() {
	# Compatible with both bash and zsh
	command -v "$1" >/dev/null 2>&1
	return $?
}

jsonValue() {
	key=$1
	num=$2
	awk -F"[,:}]" '{for(i=1;i<=NF;i++){if($i~/'$key'\042/){print $(i+1)}}}' | tr -d '"' | sed -n ${num}p
}

vercomp() {
	# Simplified version comparison compatible with bash and zsh
	if [[ $1 == "$2" ]]; then
		return 0
	fi

	# Convert versions to comparable format
	local v1 v2
	v1=$(echo "$1" | awk -F. '{ printf("%d%03d%03d", $1,$2,$3); }')
	v2=$(echo "$2" | awk -F. '{ printf("%d%03d%03d", $1,$2,$3); }')

	if [[ $v1 -gt $v2 ]]; then
		return 1
	elif [[ $v1 -lt $v2 ]]; then
		return 2
	fi
	return 0
}
