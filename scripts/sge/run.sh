#!/bin/bash
#
#$ -cwd
#$ -S /bin/bash
#$ -j n
#$ -o logs/output.$JOB_NAME.$TASK_ID.txt
#$ -e logs/output.$JOB_NAME.$TASK_ID.err
#$ -p 0
#$ -m a
#$ -M busche@ismll.de
#$ -R y

if [ $JAVA_HOME'w' = 'w' ]; then
	export JAVA_HOME=/usr/java/latest
fi

cp="."
for f in `ls *.jar -1`; do
        cp=${cp}":"${f}
done
#xmx=$1
#xmx="-Xmx4G"
#shift
mem=`ulimit -v`
if [ 'x'$memlimit = 'xunlimited' ]; then
	echo "unlimited memory - hooray!"
	mem=`cat /proc/meminfo |grep MemTotal |awk ' { print $2 } '`
fi

source ./memlib.sh
res=$?
if [ ! $res = 0 ]; then
	echo "unable to source memlib.sh (\$?=${res}. Does if exist?"
	exit 1
fi

echo meta.queue=$QUEUE
if [ ! -f /acogpr/meta/$QUEUE ]; then
	echo "ERROR: /acogpr/meta/$QUEUE does not exist. Don't know where to search memory lookup file..."
	echo "Using default value which is probably wrong ..."
	val=10
else
	memlookup=$(($mem/102400))
	echo meta.memlimit=${memlookup}00M
	val=$(get_xmx /acogpr/meta/$QUEUE $memlookup )
fi 
xmx="-Xmx"$val"00M"
echo "meta.xmx=$xmx (calculated or estimated!)"
echo meta.cp=${cp}
echo meta.hostname=$HOSTNAME
echo meta.date.start=`date`
echo meta.numslots=$NSLOTS

java -XX:ParallelGCThreads=1 -XX:ConcGCThreads=1 ${xmx} -classpath $cp $JAVA_OPTS de.ismll.console.Generic "$@"

echo meta.date.end=`date`
