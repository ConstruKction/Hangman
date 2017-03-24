# Hangman in Bash
Hangman in Bash for school created by Patryk Divković and Kyle Fransen.

__Installation__

Just clone the repo (https://github.com/ConstruKction/Hangman/) whenever you want, go into the directory and type `./hangman.sh -w` or `./hangman.sh -d` in your terminal.

**Note!**
`words` or `wordlist` is required in order to generate a random word to play with!
In most cases, `words` should be installed, but for systems with a minimal installation for example, it may be absent.
On Debian and Ubuntu, the `words` file is provided by the `wordlist` package, or its provider packages `wbritish`, `wamerican`, etc. On Fedora and Arch, the `words` file is provided by the `words` package.

__Manpage__

Run `install_manpage.sh` script in your terminal emulator in order to install the manpage.
Afterward, the `man hangman` command should be available (tested on Ubuntu and Fedora only!)

If you do not wish to install the manpage, you may use the `man ./hangman.6` command to take a peek.

Having problems with the manpage script?
Use the install command as follows:

`install -g 0 -o 0 -m 0644 hangman.6 /path-to-your-distros-man-directory/man6/`

`gzip /path-to-your-distros-man-directory/man6/hangman.6`
