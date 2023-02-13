#!/bin/bash

max_hour=1
max_minute=0

sed "" "../data/keep.txt" > "../data/keep.txt"

ps aux | grep firefox | awk '{print $9}'>>keep.txt
a=$(python3 /inter.py)

b=$(date +%H:%M)

let "minute=($(echo $b | tail -c 3) - $(echo $a | tail -c 3))"

let "hour=($(echo $b | head -c 2) - $(echo $a | head -c 2))"

pId=$(ps aux | grep firefox | awk '{print $2}')

let "pId=$(echo $pId | head -c 4)"

if [ $hour -gt $max_hour ]
then
        kill $pId

fi

if [ $hour -eq $max_hour ]
then
        if [ $minute -gt $max_minute ]
        then
                kill $pId
        fi

fi
