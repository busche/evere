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
xmx=$1
#xmx="-Xmx4G"
shift
mem=`ulimit -v`
if [ 'x'$memlimit = 'xunlimited']; then
	echo "unlimited memory - hooray!"
	mem=`cat /proc/meminfo |grep MemTotal |awk ' { print $2 } '`
fi

source ./memlib.sh
if [ ! $? = 0 ]; then
	echo "unable to source memlib.sh. Does if exist?"
	exit 1
fi
echo $QUEUE
val=$(get_xmx /acogpr/meta/$QUEUE $(($mem/102400)) )
xmx="-Xmx"$val"00M"

echo meta.cp=${cp}
echo meta.hostname=$HOSTNAME
echo meta.date.start=`date`
echo meta.numslots=$NSLOTS

java -XX:ParallelGCThreads=1 -XX:ConcGCThreads=1 ${xmx} -classpath $cp $JAVA_OPTS de.ismll.console.Generic "$@"

echo meta.date.end=`date`
