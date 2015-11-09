# Bash Option Parser

A simple library that handles the storage and retrieval of simple text options for use in BASH

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