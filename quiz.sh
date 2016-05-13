#!/bin/bash

red=$'\e[1;31m'
grn=$'\e[1;32m'
yel=$'\e[1;33m'
blu=$'\e[1;34m'
mag=$'\e[1;35m'
cyn=$'\e[1;36m'
end=$'\e[0m'

declare Ready="Ready for testing your commands skills???"
function ready {
	local Ready="1 2 3.. set go !"
	echo $Ready
}
echo $Ready
ready
echo $Ready

displayQuiz() {
	while [[ true ]]; do
		printf "\n"
		printf "${cyn}${1} ${end}"
		read -p "Answer:" answer
		if [[ $answer = ${2} ]]; then
			printf "${grn}Thats the correct answer. Below is the command output! ${end} \n"
			eval $answer
			break 1
		else
			printf "${red}Thats an incorrect/partial answer. Below is the command output!, Please try again.${end}\n"
			eval $answer
		fi
	done
}


displayQuizWithInputOptions() {
while [[ true ]]; do
	printf "\n"
	printf "${cyn}${1} ${end}"
	select opts in ${2} ${3}; do
		case $currentdate in
			"${2}" ) printf "${grn}Thats the correct answer. Below is the command output! ${end} \n"
					 eval ${2}
					 break 2
					;;
			"${3}" ) printf "${red}Thats an incorrect/incomplete answer. Below is the command output!, Please try again.${end}\n"
					 eval ${3}
					 break
					;;
			*) echo "${red}Oversmart, try again ! ${end}"
					 break
					;;
		esac
	done
done
}

displayQuizWithNoOutput() {
	printf "\n"
	printf "${cyn}${1} ${end}"
	read -p "Answer:" answer
	if [[ $answer = ${2} ]]; then
		printf "${grn}Thats the correct answer. Below is the command output! ${end} \n"
		break 1
	else
		printf "${red}Thats an incorrect/partial answer. Below is the command output!, Please try again.${end}\n"
	fi
	
}

#Useful re-usable functions
confirmationPrompt() {
	echo "Are you sure you want to continue. Y/N?"
	set answered = "";
	while [[ ! $answered ]]; do
	#r-for escape characters, n-for total number of char to read
	read -r -n 1 -s answer 
	if [[ $answer == [Yy] ]]; then
		answered="Yes"
	elif [[ $answer == [Nn] ]]; then
		answered="No"
	fi
done
printf "You answered %s\n" $answered
}

usage(){
	cat <<<END
	sh ~/testCommands.sh
	- no special options
	- easy to follow on screen.
	END
}

usageError(){
	echo "Error: $1"
	usage
	exit $2
} >&2 #all the output goes to standard error function.

implementGetOpts() {
	while getopts "a:d:t" opts; do
		case $opts in
			a) printf "Going to perform complete set-up."
				;;
			d) printf "Going to set-up development environment."
				;;
			t) printf "Going to set-up test environment."
				;;
			*) exit 1
				;;
		esac
	done
}

bashLoadOrder(){
cat <<END
+----------------+-----------+-----------+------+
|                |Interactive|Interactive|Script|
|                |login      |non-login  |      |
+----------------+-----------+-----------+------+
|/etc/profile    |   A       |           |      |
+----------------+-----------+-----------+------+
|/etc/bash.bashrc|           |    A      |      |
+----------------+-----------+-----------+------+
|~/.bashrc       |           |    B      |      |
+----------------+-----------+-----------+------+
|~/.bash_profile |   B1      |           |      |
+----------------+-----------+-----------+------+
|~/.bash_login   |   B2      |           |      |
+----------------+-----------+-----------+------+
|~/.profile      |   B3      |           |      |
+----------------+-----------+-----------+------+
|BASH_ENV        |           |           |  A   |
+----------------+-----------+-----------+------+
|~/.bash_logout  |    C      |           |      |
+----------------+-----------+-----------+------+
END
}

#Simple Basic commands Evaluation
displayQuizWithInputOptions "Command for displaying date and time?" "date" "datetime"
displayQuiz "Command for displaing Calendar?" "cal"
displayQuiz "Command for displaying left out memory in a readable format?" "free -h"
displayQuiz "Command for displaying utilised disk in a readable format?" "du -h"
displayQuiz "Command for displaying remaining disk space in a readable format?" "df -h"
displayQuiz "Displaying directory structure in tree format? you might need to install additional packages for this." "tree"
read -p "${cyn}Do you know the bash profile boot order: ${end}" "Y" "N"
bashLoadOrder
displayQuizWithInputOptions "Command for displaying date and time?" "date" "datetime"
displayQuiz "Printing environment variables." "printenv"
displayQuiz "commands for displaying details about commands." 
printf "${grn}whatis: ${end} \n"; eval "whatis free"
printf "${grn}which: ${end} \n"; eval "which free"
printf "${grn}type: ${end} \n"; eval "type free"
displayQuizWithNoOutput "Deleted files can be recovered from ?" "~/.local/share/Trash/files"
displayQuizWithNoOutput "This will redirect the executed command onto the new terminal (whose instance is /dev/pts/16)" "route > /dev/pts/16"
eval "route > /dev/pts/1"
displayQuiz "Command to monitor a command with differences between its output" "watch -d -n 1"

#Process releated Commands

#Hardware related commands
displayQuiz "List of all PCI buses in systems & devices" "lspci"
displayQuiz "List of all USB devices" "lsusb"
displayQuiz "System architecture details" "uname -p"
displayQuiz "Which file contains CPU related information" "/proc/cpuinfo"

#Network related commands
displayQuiz "Basic of all commands to test remote server - www.googl.com" "ping www.googl.com"
displayQuiz "Command to see through route packets - www.googl.com" "traceroute www.googl.com"
displayQuiz "Command to query DNS systems" "nslookup www.googl.com"


#exit 0;



