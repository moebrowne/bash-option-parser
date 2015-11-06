#!/bin/bash

# Define the regex to match an option
regexOption='^([^=]+)=(.*)$'

# The file to load the options from
OPT_FILE="$HOME/.bash_opt"

# The character(s) that signify the start of a comment
OPT_COMMENT="#"

# Initialise some variables
declare -A opta


optParse() {
	while read line; do
		[[ $line =~ $regexOption ]]
		echo "${BASH_REMATCH[@]}"
	done < "$OPT_FILE"
}


# If we are accessing this script directly run the argument parser, useful for testing
if [ "$0" == "$BASH_SOURCE" ]; then
	optParse
fi