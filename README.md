# Bash Option Parser

A simple library that handles the storage and retrieval of simple text options for use in BASH

## Configuration

There are a couple of configuration options the parser can be passed:

### OPT_FILE

The path to the file in which you want the options to be stored

### OPT_COMMENT

The character(s) that denote the start of a comment line. Defaults to `#`

### OPT_FILE_CREATE_IF_MISSING

Whether the option file should be created if when we try and write to the option file it does not exist

### OPT_PERSIST_CHANGES

Whether requests to change or add options are made the changes should be committed to the option file.

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