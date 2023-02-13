#!/bin/bash

while [ 1 ]
do
        # determine max hour
        max_hour=1
        max_minute=0
        control_time=15

        # delete all in txt file
        sed "" "../data/keep.txt" > "../data/keep.txt"

        # get the date when software is opened write it into a txt file
        ps aux | grep firefox | awk '{print $9}'>>../data/keep.txt

        # run python file and get printed date data 
        start_time=$(python3 inter.py)

        # get process id
        pId=$(ps aux | grep firefox | awk '{print $2}')
        let "pId=$(echo $pId | head -c 4)"

        # write if it is working
        echo running...
        echo don\'t close.

        # run while firefox is open
        while [ $(pgrep firefox) ]
        do
                # get current time
                current_time=$(date +%H:%M)

                # get elapsed time (minute, hour)
                let "minute=($(echo $current_time | tail -c 3) - $(echo $start_time | tail -c 3))"
                let "hour=($(echo $current_time | head -c 2) - $(echo $start_time | head -c 2))"

                # if it is more than 1 hour kill process
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

                # while loop will be run in every determined seconds
                sleep $control_time
        done
done

# when it is ended
echo there is no firefox opened!
