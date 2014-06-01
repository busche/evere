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
	type $1 2>/dev/null | grep -q 'function'
}


# logging methods
fn_exists trace || function trace () {
	echo "TRACE: "$*
}
fn_exists info2 || function info2() {
	echo `date`" INFO: "$*
}
fn_exists warn || function warn() {
	echo `date`" WARNING: "$*
}
fn_exists error || function error() {
	echo "ERROR: "$*
}





						
