#!/bin/bash

. lifecycle.sh
. common.sh
. traputils.sh

on_init() {
	echo "on_setup:: custom set up"
}

on_run(){
#ulimit -v 1000000
	echo "on_run:: running the program"
	echo "$$"
	sleep 9
	java -version
	javaret=$?
#	sleep 1
#	echo "on_run:: quit"
	return $javaret
}


guarded_run

