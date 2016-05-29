#!/bin/bash

declare -a arr=('1:one' '2:two' '3:three');
len=${#arr[@]}
i=0
while [ $i -lt $len ]; do
	echo "${arr[$i]}"
	let i++
done
