#
# utility functions for running Java
#
#

#
# generates dynamic java options (memory setting, classpath definitions)
#
function java_generate_opts(){
	cp="."
	for f in `ls *.jar -1`; do
		cp=${cp}":"${f}
	done

	mem=`ulimit -v`
	if [ 'x'$memlimit = 'xunlimited' ]; then
#		echo "unlimited memory - hooray!"
		mem=`cat /proc/meminfo |grep MemTotal |awk ' { print $2 } '`
	fi

	# check whether java_memlib.sh exists in PATH
	which java_memlib.sh > /dev/null
	if [ ! $? = 0 ]; then
		echo "java_memlib.sh is not in PATH"
		return
	fi

	. java_memlib.sh
	res=$?
	if [ ! $res = 0 ]; then
#		echo "unable to source memlib.sh (\$?=${res}). Does if exist?"
		exit 1
	fi

#	echo meta.queue=$QUEUE >3
	if [ ! -f /acogpr/meta/$QUEUE ]; then
#		echo "ERROR: /acogpr/meta/$QUEUE does not exist. Don't know where to search memory lookup file..."
#		echo "Using default value which is probably wrong ..."
		val=10
	else
		memlookup=$(($mem/102400))
#		echo meta.memlimit=${memlookup}00M
		val=$(get_xmx /acogpr/meta/$QUEUE $memlookup )
	fi

	echo "-classpath ${cp} -Xmx"${val}"00M -Xms"${val}"00M"
}

# stub on_init function: checks whether java can be launched with standard parameters
function on_init() {
	# check whether Java launches at all
	echo "hallo"
	run_java -version > /dev/null
	err=$?

	if [ ! $err = 0 ]; then
		warn "Failed to launch java executable. Returned errorlevel $err"
	fi
}

# utility function to invoke Java using the passed parameters
run_java(){
	if [ $JAVA_HOME'w' = 'w' ]; then
		export JAVA_HOME=/usr/java/latest
	fi
	
	JAVA_OPTS=" $JAVA_OPTS -XX:ParallelGCThreads=1 -XX:ConcGCThreads=1 "
	java_opts=$(java_generate_opts)
	
	echo "calling java $JAVA_OPTS $java_opts ""$@"
	java $JAVA_OPTS $java_opts "$@"

}



