
function sighandler_trap_INT(){
	echo "SIGINT"
	exit 0
}

function fn_exists()
{
    type $1 | grep -q 'shell function'
}

fn_exists on_setup || on_setup(){ echo "stubbed on_setup"; }

#trap 'sighandler_trap_INT' 2


function guarded_run(){

trap 'sighandler_trap_INT' 2
on_setup
echo "starting at `date`"
on_run
echo "stopping at `date`"

}

#i=0
#while [ $i -lt 5 ]
#do
#  echo "Bitte nicht stören! ($$)"
#  sleep 3
#  i=`expr $i + 1`
#done
