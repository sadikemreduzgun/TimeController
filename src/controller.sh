#!/bin/bash

# determine max hour
max_hour=1
max_minute=0
control_time=15

# delete all in txt file
sed "" "../data/keep.txt" > "../data/keep.txt"

# get the date when software is opened write it into a txt file
ps aux | grep firefox | awk '{print $9}'>>keep.txt

# run python file and get printed date data 
start_time=$(python3 /inter.py)
pId=$(ps aux | grep firefox | awk '{print $2}')

while [ kill -0 $pid ]
do
        # get current time
        current_time=$(date +%H:%M)

        # get elapsed time (minute, hour)
        let "minute=($(echo $current_time | tail -c 3) - $(echo $start_time | tail -c 3))"
        let "hour=($(echo $current_time | head -c 2) - $(echo $start_time | head -c 2))"
        
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
        sleep $control_time
done
