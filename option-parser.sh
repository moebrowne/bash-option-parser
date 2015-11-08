#!/bin/bash

# The file to load the options from
OPT_FILE="$HOME/.bash_opt"

# The character(s) that signify the start of a comment
OPT_COMMENT="#"

# Debug mode
OPT_DEBUG=true

# Define the regex to match an option
regexOption="^[:space:]*([^=[:space:]$OPT_COMMENT]+)[[:space:]]*=[[:space:]]*(.*)$"

# Initialise some variables
declare -A opts

optExists() {
	if [ -z ${opts["$1"]+abc} ]; then
		return 1
	else
		return 0
	fi
}

optValue() {
	if argExists "$1"; then
		echo "${opts["$1"]}"
	fi
}

optParse() {

	# Set the line counter to 0
	lineNo=0

	# Loop over every line of the option file
	while read line; do

		# Increment the line counter
		lineNo=$((lineNo + 1))

		# Try and match the line against our REGEX
		[[ $line =~ $regexOption ]]
		if [[ ${BASH_REMATCH[@]} == '' ]]; then
			# Nothing matched the regex
			continue
		fi

		# Get the key/value pairs
		key="${BASH_REMATCH[1]}"
		value="${BASH_REMATCH[2]}"

		# Add the value to the associative array
		opts["$key"]="$value"

	done < "$OPT_FILE"
}

optWrite() {

}

# If we are accessing this script directly run the argument parser, useful for testing
if [ "$0" == "$BASH_SOURCE" ]; then
	optParse

	[ "$OPT_DEBUG" == true ] && for k in "${!opts[@]}"
	do
		echo "OPT: $k = ${opts[$k]}"
	done
fi