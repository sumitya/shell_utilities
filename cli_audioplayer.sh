#!/bin/bash
# Description : cli_audioplayer for playing audio songs availble on pc from andriod phone
# Author : syadav
# Date : 2016-05-22
# Comments : initial version of software

#find all the mp3 songs file on the system.
find / -name *.mp3 2>/dev/null |grep -v .Trash* > mp3songs >&1

#add " to the begining and end of a file
awk '{print "\""$0"\""}' mp3songs > mp3songs_actual




song(){
timestamp=`date +%y-%m-%d`
rm  ~/temp_${timestamp}/*.mp3 
printf "You have below 10 songs to play\n"
printf "===========================================================\n"

mkdir -p ~/temp_${timestamp}
#counter to be displayed in selection of song
counter=1
while read -r line; do
	songnm=`basename "$line"`
	printf "[ %s$songnm ] Press: $counter\n"
 	
	eval ln -s "$line" ~/temp_${timestamp}/s${counter}.mp3			
	
	if [ `expr ${counter} % 10` -eq 0 ]; then
		printf "===========================================================\n"
		printf "Want to play any of them(Y/n)\n"
	    	read var </dev/tty
			if [ "$var" = "Y" ]; then
				 printf "Press option out of (1|2|3|4|5|6|7|8|9|10)\n"
				 read option </dev/tty
		 		 eval nohup play ~/temp_${timestamp}/s${option}.mp3 2>&1 /dev/null &
				 printf "Want to see next list of songs... \n" 
			else 
				rm  ~/temp_${timestamp}/*.mp3 
				counter=0
				clear
				printf "Displaying next 10 song list\n"
			fi
	fi
	counter=$((counter+1))
	
done < mp3songs_actual
}
stop(){
processid=`ps -ef|grep s*.mp3|head -1|awk '{print $2}'`
kill -9 $processid
}
"$@"
