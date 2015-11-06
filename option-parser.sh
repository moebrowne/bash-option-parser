#!/bin/bash

# Define the regex to match an option
regexOption='^([^\s=]) ?= ?(.*)$'

# The file to load the options from
OPT_FILE="~/.bash_opt"

# Initialise some variables
declare -A opta


optParse() {
	echo "Hello World!"
}


# If we are accessing this script directly run the argument parser, useful for testing
if [ "$0" == "$BASH_SOURCE" ]; then
	optParse
fi