# is the task name ok?
#
# Input:
#  - $1: task name
# Side-effect:
#  - die on error
sanity_check_task() {
  if echo $1 | $GREP '/' >/dev/null
  then
    die "Task names cannot contain '/'"
  fi
}
  
# Does the given task already exist?
#
# Input:
#  - $1: task name
# Output:
#  - zero return status if the task already exists
task_exists() {
  sanity_check_task "$1" && test -e "$DEV_TASKS_DIR/$1.dev"
}
