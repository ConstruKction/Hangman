#!/bin/bash

install_manpage() {
	echo "Please allow sudo access in order to install the manpage."

	sudo install -g 0 -o 0 -m 0644 hangman.6 /usr/share/man/man6
	sudo gzip /usr/share/man/man6/hangman.6
}

install_manpage
