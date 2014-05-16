
#
# default implementation of INT trap
#
#
#
function sighandler_trap_INT(){
	echo "SIGINT"
	exit 0
}

#
# utility function for checking function existence
#
# taken from http://stackoverflow.com/questions/85880/determine-if-a-function-exists-in-bash
#
function fn_exists()
{
    type $1 2>/dev/null | grep -q 'shell function'
}

# define on_setup if it is not (yet) defined
fn_exists on_setup || on_setup() {
echo "stubbed on_setup"
}

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
