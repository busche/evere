#!/bin/bash

. traputils.sh

on_setup() {
	echo "custom set up"
}

on_run(){

	echo "running the program"
	sleep 10
	echo "quit"

}


guarded_run

