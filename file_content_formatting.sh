#http://stackoverflow.com/questions/37567976/adding-fields-to-a-specific-position-of-the-file-for-each-record-in-unix
#https://linuxconfig.org/bash-printf-syntax-basics-with-examples
#http://wiki.bash-hackers.org/commands/builtin/printf

#!/bin/bash

pos_arr=()
no_of_delim=()

printf 'please maintain sequence of inputs to get expected result.\n'

	while :
	do
		printf 'Enter character position from where to insert some characters\n'
		read loc
		pos_arr+=($loc)
		printf 'Enter which character to insert\n'
		read delim
		printf 'Enter no. of characters to insert\n'
		read occur
		no_of_delim+=($occur)
		printf 'Do you want to do more formatting(Y/n)\n'
		read option
			if [ "$option" == "n" ]; then 
				break;
			fi
		#printf " ${pos_arr[0]}"
	done


pos_array_len=`echo ${#pos_arr[@]}`
while line in `cat file.txt`; do
	echo $line > file_temp.txt
	for (i=0,j=0;i<pos_array_len;i++,j++); do

		content=`cat file_temp.txt`
		
		pos=pos_arr[i]
		next_pos=`${pos}+1`
		end=`echo ${#content}`
		last=`cut -c$next_pos-$end file_temp.txt`
		---------middle=delim*no_of_delim[]
		begin=`cut -c1-$pos file_temp.txt`
		printf '$begin$middle$last' > file_temp.txt
		
	#or
	
	#print formatted output to a file using awk
	awk '{print substr($1,0,'"$pos"')"'"$middle"'"substr($1,'"$next_pos"',length($1))}' file.txt > file_temp.txt
	done

file_temp.txt >> file_final_formatted.txt

done

# align all text flush right on a 79-column width
 sed -e :a -e 's/^.\{1,78\}$/ &/;ta'  # set at 78 plus 1 space