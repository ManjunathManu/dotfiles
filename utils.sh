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

typeExists() {
	if [ $(type -P $1) ]; then
		return 0
	fi
	return 1
}

jsonValue() {
	key=$1
	num=$2
	awk -F"[,:}]" '{for(i=1;i<=NF;i++){if($i~/'$key'\042/){print $(i+1)}}}' | tr -d '"' | sed -n ${num}p
}

vercomp() {
	if [[ $1 == $2 ]]
	then
		return 0
	fi
	local IFS=.
	local i ver1=($1) ver2=($2)

	# fill empty fields in ver1 with zeros
	for ((i=${#ver1[@]}; i<${#ver2[@]}; i++))
	do
		ver1[i]=0
	done

	for ((i=0; i<${#ver1[@]}; i++))
	do
		if [[ -z ${ver2[i]} ]]
		then
			# fill empty fields in ver2 with zeros
			ver2[i]=0
		fi
		if ((10#${ver1[i]} > 10#${ver2[i]}))
		then
			return 1
		fi
		if ((10#${ver1[i]} < 10#${ver2[i]}))
		then
			return 2
		fi
	done
	return 0
}
