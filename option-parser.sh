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
declare -A optLines

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

		# Add the line number of this option to an associative array
		optLines["$key"]="$lineNo"

	done < "$OPT_FILE"
}

optWrite() {

	# The key of the option we want to write to
	local key="$1";

	# The new value we want to give the option
	local value="$2"

	# Check if this is a new option
	if [ ! -z ${optLines["$1"]+abc} ]; then

		# Get the line number of this option
		local lineNo=${optLines["$1"]}

		# Remove the option
		sed -i "${lineNo}d" "$OPT_FILE"

		# Write the new option
		sed -i "${lineNo}i$1=$2" "$OPT_FILE"

		# Update the array
		opts["$1"]="$2"

		# Nothing more to do
		return;

	fi

	# Add the new option to the end of the option file
	echo "$1=$2" >> "$OPT_FILE"

}

# If we are accessing this script directly run the argument parser, useful for testing
if [ "$0" == "$BASH_SOURCE" ]; then
	optParse

	[ "$OPT_DEBUG" == true ] && for k in "${!opts[@]}"
	do
		echo "OPT: $k = ${opts[$k]}"
	done
fi