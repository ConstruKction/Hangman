#!/bin/bash
. hangman_functions.sh

while getopts ":hwd" o; do
	case "$o" in
		h)
			echo "-h: help"
			echo "-w: chosen word"
			echo "-d: random word"
			;;
		w)
			welcome_word
			;;
		d)
			welcome_words
			;;
		*)
			usage
			;;
	esac
done
