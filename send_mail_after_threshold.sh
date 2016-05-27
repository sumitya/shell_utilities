#!/bin/bash
filename = '/home/syadav/SPOOL/error.txt'

while read -r line;
do
id =`echo $line`
    if [ $id -gt 100 ]; then
        mailx -s "You have $id errors" email@gmail.com  < /home/syadav/SPOOL/output.txt
    fi
sleep 5
done < filename
