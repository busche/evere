#!/bin/bash

function get_mem() {
#       echo "calculating memory for $1 at a required minimum of $2"
        ret=""
        while read line; do

        	#read the line
        	read key value <<<$line
       		if [ $key -gt $2 ]; then
	        	ret=$value
                	break
        	fi

        done < <(cat $1) # of while

        if [ 'x'$ret = 'x' ]; then
                # fallback if no mem value was found.
                ret=130
        fi
        echo $ret
}

function get_xmx() {
#       echo "calculating memory for $1 at a required minimum of $2"
        ret=""
        while read line; do

        	#read the line
        	read key value <<<$line
       		if [ $value -gt $2 ]; then
	        	ret=$key
                	break
        	fi

        done < <(cat $1) # of while

        if [ 'x'$ret = 'x' ]; then
                # fallback if no mem value was found.
                ret=130
        fi
        echo $ret
}


#mem=$(get_mem "$1" $2)
#echo mem is $mem


