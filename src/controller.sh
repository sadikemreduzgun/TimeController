#!/bin/bash

# assign max time variables
max_hour=1
max_minute=0

# assign checking time
control_time=15

# determine which software is goning to be checked
software=firefox

# booleans to stop it from givin info one-by another
bool=1
bool2=1

while [ 1 ]
do

        # delete all in txt file
        sed "" "../data/keep.txt" > "../data/keep.txt"

        # get the date when software is opened write it into a txt file
        ps aux | grep $software | awk '{print $9}'>>../data/keep.txt

        # run python file and get printed date data 
        start_time=$(python3 inter.py)

        # get process id
        pId=$(ps aux | grep $software | awk '{print $2}')
        let "pId=$(echo $pId | head -c 4)"

        # run while firefox is open
        while [ $(pgrep $software) ]
        do
		# write if it is working
		if [ $bool2 -eq 1 ]
		then
			echo running...
			echo don\'t close.
			bool2=0

		fi
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
				bool=1
                        fi

                fi

                # while loop will be run in every determined seconds
                sleep $control_time
        done

	# when it is ended
       	if [ $bool -eq 1 ]
	then
        	
        	echo there is no $software opened! 
		bool=0
	fi

	# sleep it to stop it eating memory
        sleep $control_time
done
