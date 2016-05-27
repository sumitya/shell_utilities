#!/bin/bash
hadoop fs -ls /archivedData/Mappings/Web/NOW/| while read path; do 
dir_date=`echo $path | awk '{print $6}'`|cut -d'/' -f5
purge_criteria=`date +"%Y%m%d%H%M" --date "7 days ago"`
	if [ $dir_date -lt $purge_criteria ]; then
	hadoop fs -rm $f
	fi
done