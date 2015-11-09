# Bash Option Parser

A simple library that handles the storage and retrieval of simple text options for use in BASH

## Configuration

There are a couple of configuration options the parser can be passed:

### OPT_FILE

The path to the file in which you want the options to be stored

## Option File Format

The options are stored in the following format:

```shell
optionName=optionvalue
#commentedOption=TestValue
quoted="some long string"
whiteSpaceTolerance = myValue
	tabbedOption="Tab all the options"
	#Tabbed Comments are ok to
```