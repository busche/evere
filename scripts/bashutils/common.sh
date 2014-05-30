#
# common.sh
#
# common functionalitites of evere which are used in all component scripts.
#
# functions defined here:
#  -fn_exists


#
# utility function for checking function existence
#
# taken from http://stackoverflow.com/questions/85880/determine-if-a-function-exists-in-bash
#
function fn_exists()
{
	type $1 2>/dev/null | grep -q 'shell function'
}




# logging methods
fn_exists on_init || function trace () {
	echo "TRACE: "$*
}
fn_exists on_init || function error() {
	echo "ERROR: "$*
}
fn_exists on_init || function warn() {
	echo `date`" WARNING: "$*
}





						
