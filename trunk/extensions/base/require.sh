# is the tasktype name ok?
#
# Input:
#  - $1: task name
# Side-effect:
#  - die on error
sanity_check_tasktype() {
  test x"$1" = x"" && die "An empty task name is not allowed"
  if echo $1 | $GREP '/' >/dev/null
  then
    die "Task names cannot contain '/'"
  fi
}
  
# Does the given tasktype already exist?
#
# Input:
#  - $1: task name
# Output:
#  - zero return status if the task already exists
tasktype_exists() {
  sanity_check_tasktype "$1" && test -e "$DEV_TASKTYPES_DIR/$1.dev"
}

# Is there a current task?
#
# Input: nothing
# Output:
#  - zero return status if there is a current task
have_task() {
  test -n "$DEV_TASK_DIR"
}

# Edit the given file, dying with a reasonable error message of $EDITOR is
# not defined.
#
# Input:
#  - $1: filename
edit_file() {
    test "$EDITOR" != "" || die "\$EDITOR is not defined"
    $EDITOR "$1"
}
