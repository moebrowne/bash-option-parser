#!/bin/bash

# The file to load the options from
OPT_FILE="$HOME/.bash_opt"

# The character(s) that signify the start of a comment
OPT_COMMENT="#"

# Define the regex to match an option
regexOption="^([^=$OPT_COMMENT]+)=(.*)$"

# Initialise some variables
declare -A opta


optParse() {

	# Set the line counter to 0
	lineNo=0

	# Loop over every line of the option file
	while read line; do

		# Increment the line counter
		lineNo=$((lineNo + 1))

		# echo the line number before any output
		echo -n "$lineNo: "

		# Try and match the line against our REGEX
		[[ $line =~ $regexOption ]]

		echo "${BASH_REMATCH[@]}"

	done < "$OPT_FILE"
}


# If we are accessing this script directly run the argument parser, useful for testing
if [ "$0" == "$BASH_SOURCE" ]; then
	optParse
fi