# a collection of useful functions

# is the current WIP loaded?
wip_is_loaded() {
  [ -d "$DEV_STATUS_DIR" ]
}

# return the path to the loaded task
loaded_task() {
  if wip_is_loaded 
  then
    cat "$DEV_STATUS_DIR/taskname"
  else
    echo '(none)'
  fi
}

source_task() {
    source "$DEV_STATUS_DIR/task/taskrc"
}

# call a taskrc function
call_taskrc() {
  (
    source_task
    for src in "$libdir/dev/task_functions.sh" "$DEV_PROJECT/lib/dev/task_functions.sh"
    do
      [ -f $src ] && source $src
    done
    cd $DEV_PROJECT
    $1
  )
}

# issue a short warning before doing something harmful
warning_countdown() {
  echo "WARNING: $1"
  echo -ne "Three seconds to abort: "
  for x in 3 ... 2 ... 1 ...; do
    echo -ne "$x "
    LC_ALL=C sleep .5
  done
  echo 'proceeding!'
}

####
## Task management

task_exists() {
  [ -e $DEV_TASKS_DIR/$1 ]
}

task_path()  {
  echo $DEV_TASKS_DIR/$1
}

####
## Error handling

# is the task name ok?
sanity_check_task() {
  if echo $1 | $GREP '/' >/dev/null
  then
    die "Task names cannot contain '/'"
  fi
}
  
# die with an error
die() {
  echo "$@"
  exit 1
}

## source project-local stuff
[ -f $DEV_PROJECT/lib/dev/functions.sh ] && source $DEV_PROJECT/lib/dev/functions.sh
