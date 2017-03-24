#!/bin/bash

declare word
declare counter=0
declare error=0
declare correct=0
declare letters="&"
declare alphabet="abcdefghijklmnopqrstuvwxyz"

trap ctrl_c INT

ctrl_c() {
	echo "You stopped the script."
	if [[ `echo -n $word | wc -m` == 0 ]]
	then
		echo "Goodbye."
	else
		echo "The word was: $word."
		echo "Goodbye."
	fi

	exit 0
}

welcome_word() {
cat << "EOF"
 _                                             
| |__   __ _ _ __   __ _ _ __ ___   __ _ _ __  
| '_ \ / _` | '_ \ / _` | '_ ` _ \ / _` | '_ \ 
| | | | (_| | | | | (_| | | | | | | (_| | | | |
|_| |_|\__,_|_| |_|\__, |_| |_| |_|\__,_|_| |_|
                   |___/                       
EOF
echo "Welcome to hangman! Please choose your word:"
read input_word
word=$input_word
guess_letter
}

welcome_words() {
cat << "EOF"
 _                                             
| |__   __ _ _ __   __ _ _ __ ___   __ _ _ __  
| '_ \ / _` | '_ \ / _` | '_ ` _ \ / _` | '_ \ 
| | | | (_| | | | | (_| | | | | | | (_| | | | |
|_| |_|\__,_|_| |_|\__, |_| |_| |_|\__,_|_| |_|
                   |___/                       

Welcome to hangman! Start guessing!
EOF
word=`shuf -n 1 /usr/share/dict/words`
guess_letter
}

show_bottom_support() {
cat << "EOF"
    _____
EOF
}

show_vertical_pole() {
cat << "EOF"
      
     |
     |      
     |     
     |     
     |     
     |
    _|___
EOF
}

show_hang_pole() {
cat << "EOF"
      _______
     |/      
     |     
     |    
     |    
     |    
     |
    _|___
EOF
}

show_rope() {
cat << "EOF"
      _______
     |/      |
     |      
     |      
     |      
     |      
     |
    _|___
EOF
}

show_head() {
cat << "EOF"
      _______
     |/      |
     |      (_)
     |      
     |      
     |     
     |
    _|___
EOF
}

show_torso() {
cat << "EOF"
      _______
     |/      |
     |      (_)
     |       |
     |       |
     |       
     |
    _|___
EOF
}

show_left_arm() {
cat << "EOF"
      _______
     |/      |
     |      (_)
     |      \|
     |       |
     |       
     |
    _|___
EOF
}

show_right_arm() {
cat << "EOF"
      _______
     |/      |
     |      (_)
     |      \|/
     |       |
     |       
     |
    _|___
EOF
}

show_left_leg() {
cat << "EOF"
      _______
     |/      |
     |      (_)
     |      \|/
     |       |
     |      / 
     |
    _|___
EOF
}

show_hangman() {
cat << "EOF"
      _______
     |/      |
     |      (_) <(*choking sounds*)
     |      \|/
     |       |
     |      / \
     |
    _|___
EOF
}

end() {
	echo "The word was: $word."
	unset word
	unset error
	unset correct
	unset letters
	letters="&"
	error=0

	read -p "Play again? (y/N)?" choice
	case "$choice" in 
    	y|Y)
		cat << "EOF"
 _                                             
| |__   __ _ _ __   __ _ _ __ ___   __ _ _ __  
| '_ \ / _` | '_ \ / _` | '_ ` _ \ / _` | '_ \ 
| | | | (_| | | | | (_| | | | | | | (_| | | | |
|_| |_|\__,_|_| |_|\__, |_| |_| |_|\__,_|_| |_|
				   |___/                       
EOF
			echo "Type your word or leave empty for random:" 
			read new_word
			if [[ `echo -n $new_word | wc -m` == 0 ]]
			then
				welcome_words
			else
				word=$new_word
				guess_letter
			fi
		;;
  		n|N) 
			echo "Come back soon!"
			exit
			;;
  		*) 
			echo "Come back soon!"
			exit 
			;;
	esac
}

usage() {
	echo "hangman: usage: hangman -w"
	echo "hangman: usage: hangman -d"
	exit 1
}

guess_letter() {
	echo "Available letters: `echo "$alphabet" | tr $letters " "`"

	read input_letter

	if [[ `echo -n $input_letter | wc -m` == 1 ]]
	then
		if [[ "$letters" =~ "$input_letter" ]]
		then
			echo "Already guessed this character! Try again: "
			guess_letter
		else
			if [[ $word == *"$input_letter"* ]] 
			then
				clear
				echo "It's there!"
				let "correct++"
			else
				clear
				echo "It's not there! Tries left: `expr 9 - $error`"
				let "error++"
			fi
			letters="$letters$input_letter"

			for (( i=0; i<${#word}; i++ )); do
				if [[ "$letters" == *"${word:$i:1}"* ]]
				then
					echo -n "${word:$i:1}" | tr -d "\n"
				else
					echo "." | tr -d "\n"
				fi
			done
			printf "\n"

			case "$error" in
				"1")
					show_bottom_support
					;;
				"2")
					show_vertical_pole
					;;
				"3")
					show_hang_pole
					;;
				"4")	
					show_rope
					;;
				"5")
					show_head
					;;
				"6")
					show_torso
					;;
				"7")
					show_left_arm
					;;
				"8")
					show_right_arm
					;;
				"9")
					show_left_leg
					;;
				"10")
					show_hangman
					echo "You've lost!"
					end
					;;
				*)
			esac

			if [[ $correct == `echo -n $word | grep -o . | sort | tr -d "\n" | tr -d \'\" | tr -s 'a-z' | wc -m` ]]
			then
				echo "You guessed it!"
				end
			fi	
		
			guess_letter
		fi
	else
		echo "Invalid input!"
		guess_letter
	fi
}
