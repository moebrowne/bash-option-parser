#!/bin/bash

# The file to load the options from
OPT_FILE="$HOME/.bash_opt"

# The character(s) that signify the start of a comment
OPT_COMMENT="#"

# Define the regex to match an option
regexOption="^[:space:]*([^=[:space:]$OPT_COMMENT]+)[[:space:]]*=[[:space:]]*(.*)$"

# Initialise some variables
declare -A opts


optParse() {

	# Set the line counter to 0
	lineNo=0

	# Loop over every line of the option file
	while read line; do

		# Increment the line counter
		lineNo=$((lineNo + 1))

		# echo the line number before any output
		echo -n "$lineNo	"

		echo -n "$line	"

		# Try and match the line against our REGEX
		[[ $line =~ $regexOption ]]

		if [[ ${BASH_REMATCH[@]} == '' ]]; then
			echo "-- NO MATCH --"
			continue
		fi

		# Get the key/value pairs
		key="${BASH_REMATCH[1]}"
		value="${BASH_REMATCH[2]}"

		# Echo the key/value pair
		echo "$key	$value	"

	done < "$OPT_FILE"
}


# If we are accessing this script directly run the argument parser, useful for testing
if [ "$0" == "$BASH_SOURCE" ]; then
	optParse | column -t -s $'\t'
fi