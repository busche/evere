
#
# default implementation of INT trap
#
#
#
function sighandler_trap_INT(){
	echo "SIGINT"
#	exit 0
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

# define stubs if it is not (yet) defined
fn_exists on_success || function on_success() { 
	echo "stubbed on_succes" 
}
fn_exists on_init || function on_init() { 
	echo "stubbed on_init" 
}
fn_exists on_abort || function on_abort() { 
	echo "stubbed on_abort" 
}
fn_exists on_exit || function on_exit() { 
	echo "stubbed on_exit" 
}

# define logging methods
function trace () {
	echo "TRACE: "$*
}
function error() {
	echo "ERROR: "$*
}
#trap 'sighandler_trap_INT' 2

#
# main function, guarding the on_run method
#
# currently,  this mostly creates a simple lifecycle by calling callback methods.
#
function guarded_run() {

	# register traps this should be handled
	trap 'sighandler_trap_INT' 2

	# initialize calling on_init
	trace "calling on_init"
	on_init
	trace "on_init finished"

	# call on_run
	trace "calling on_run"
	echo "starting at `date`"
	on_run
	retval=$?
	trace "on_run finished, returnvalue=$retval"

	echo "stopping at `date` with errorlevel $retval"

	if [ 'x'$retval = 'x' ]; then
		error "guarded_run:: invalid return value (null) from do_run method. Please return an appropriate return value (e.g., 0 on success)"
	else
		if [ $retval = 0 ]; then
			trace "calling on_success"
			on_success
			trace "on_success finished"
		else
			trace "calling on_abort"
			on_abort
			trace "on_abort finished"
		fi	
	fi
	trace "calling on_exit"
	on_exit	
	trace "on_exit finished"
}

#i=0
#while [ $i -lt 5 ]
#do
#  echo "Bitte nicht stören! ($$)"
#  sleep 3
#  i=`expr $i + 1`
#done
