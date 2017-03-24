#!/bin/bash
. hangman_functions.sh

if [ $# -eq 0 ]
then
	usage
fi

if [ $1 == '-w' ]
then
	welcome_word
elif [ $1 == '-d' ]
then
	welcome_words
else
	usage
fi
