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
  sanity_check_task "$1" && test -e "$DEV_TASKS_DIR/$1"
}

# Given a task name return the path to its task 
# configuration directory
#
# Input:
#  - $1: task name
# Output:
#  - task configuration directory on stdout
task_to_config_path()  {
  echo "$DEV_TASKS_DIR/$1"
}
