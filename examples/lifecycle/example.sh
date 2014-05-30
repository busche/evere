#!/bin/bash

#
# to run this example from within evere, set the following path:
#
# PATH=$PATH:../../scripts/bashutils/:../../scripts/traps/:../../scripts/lifecycle/ ./example.sh

# include helper functions
. lifecycleutils.sh
. common.sh
. traputils.sh

# dummy output for on_init
on_init() {
	echo "on_setup:: custom set up"
}

# runs some examples
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

# execute the lifecycle
guarded_run

