#!/bin/bash
# 
# Author:  jarring2 
# Date  :  11/25/19 
# Program Name: grader 
# Objective: find average and assign grade to each person

calc_grade() {
        (($# != 1)) && echo "usage: $basedir $0) average" && return 1
        avg=$1
        if ((avg >= 90)); then
                grade="A"
        elif((avg >= 80));then
                grade="B"
        elif((avg >= 70));then
                grade="C"
        elif((avg >= 60)); then
                grade="D"
        else
                grade="F"
        fi
	echo $grade
}

rm gradedfile 2> /dev/null

cat $1 | grep ^[A-Za-z] > temp

header1=$(sed -n '1p' $1)
header2=$(sed -n '2,2p' $1)

header1=${header1}"avg***grade***"
header2=${header2}"-----------------"

echo $header1  > gradedfile
echo $header2 >> gradedfile
#echo $header2 >> gradedfile
#echo $header2|head -2 | tail -1 >> gradedfile
#echo $header2| grep ^[^A-Za-z] >> gradedfile
cat temp | while read line;do
	q1=$(echo $line | awk '{print $2}')
	q2=$(echo $line | awk '{print $3}')
	q3=$(echo $line | awk '{print $4}')
	fin=$(echo $line | awk '{print $5}')
	avg=$(((q1+q2+q3+fin)/4))
	echo "   $avg  " >> avg
	ltr=$(calc_grade $avg)
	echo "   $ltr" >> ltr
done

paste -d "" avg ltr >> grdltr
paste -d "" temp grdltr >> gradedfile
rm temp && rm avg && rm ltr && rm grdltr 


