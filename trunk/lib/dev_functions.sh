# Utility functions for 'dev'

# Search out from the current directory for a directory containing $1.
#
# Input:
#  - $1: the file to search for
# Output:
#  - directory containing that file on stdout, or an empty string if 
#    not found.
# Side-effects:
#  - Current directory is changed (run the function in a subshell to 
#    avoid this)
search_up_dir_tree() {
    last_dir=`pwd`
    while true; do
        if test -e "$1" ; then
            pwd
            break
        fi
        cd ..
        this_dir=`pwd`
        if test x"$last_dir" = x"$this_dir"; then
            break
        fi
        last_dir="$this_dir"
    done
}

# Search for a task directory according to the algorithm given in the wiki.
#
# Output:
#  - set $DEV_TASK_DIR (exported) to the task directory, or to an empty
#    string if not found
set_task_dir() {
    export DEV_TASK_DIR=`search_up_dir_tree .task`
}

# Search up from the current directory to find a directory containing
# '.devrc'.  This is the project directory.
#
# Side-effects:
#  - error message to stderr on error
# Output:
#  - set $DEV_PROJECT_DIR (exported) to the project directory
#  - exit status '1' on error
set_project_dir() {
    export DEV_PROJECT_DIR=`search_up_dir_tree .devrc`
    if test -z "$DEV_PROJECT_DIR"; then
        echo "Could not find a dev project (a directory containing .devrc)!" >&2
        return 1
    fi
}

# Enumerate the available subcommands
#
# Input:
#  $DEV_SUBCOMMANDS_PATH
# Output:
#  newline-separated list of commands on stdout
enumerate_subcommands() {
  echo 'help' # (internal command)

  local old_IFS="$IFS"
  IFS=':'
  for dir in $DEV_SUBCOMMANDS_PATH:$libdir/dev/subcommands
  do
    test -z "$dir" && continue
    for cmd in $dir/*
    do
      if test -f $cmd -a -x $cmd
      then
        echo ${cmd##$dir/}
      fi
    done
  done
  IFS="$old_IFS"
}

# Given a bare subcommand name, find the full path to its implementation.
#
# Input:
#  $1: subcommand name
# Output:
#  full path to subcommand on stdout, or empty string if not found
find_subcommand() {
  local subcommand=$1
  local old_IFS="$IFS"
  IFS=':'
  for dir in $DEV_SUBCOMMANDS_PATH:$libdir/dev/subcommands
  do
    if test -f $dir/$subcommand -a -x $dir/$subcommand
    then
      echo $dir/$subcommand
      break
    fi
  done
  IFS="$old_IFS"
}

# Print usage message and exit with status 1
usage() {
  cat <<EOF
USAGE:
  $0 [-h] [-v] subcommand <subcommand args>

  -h: this message
  -v: show version

Available subcommands are:
EOF
  # this strategy was lifted from quilt
  enumerate_subcommands | $SORT -u | $COLUMN | $COLUMN -t | $SED -e $'s/^/\t/'
  exit 1
}

# Source the current task, if $DEV_TASK_DIR is defined.
#
# Input:
#  - $DEV_TASK_DIR
# Side-effects:
#  - extensions are loaded by the 'require' function
#  - task-specific configuration is loaded
#  - task functions are defined
#  - error message to stderr on error
# Output:
#  - return status of 1 if the sourcing failed
#  - sets $DEV_TASK (exported) if a task is defined
#  - sets $DEV_TASK_CONFIG_DIR (exported) if a task is defined
source_task_configuration() {
    if test -z "$DEV_TASK_DIR"; then return; fi

    export TASK=`<"$DEV_TASK_DIR/.task"`
    if test -z "$TASK"; then
        echo ".task is empty!" >&2
        return 1
    fi

    export TASK_CONFIG_DIR="$DEV_TASKS_DIR/$TASK"
    if ! test -d "$TASK_CONFIG_DIR" || ! test -f "$TASK_CONFIG_DIR/taskrc"; then
        echo "No configuration for task '$TASK'!" >&2
        return 1
    fi

    require() {
        : # no-op for the moment
    }

    if ! source "$TASK_CONFIG_DIR/taskrc"; then
        echo "error reading '$TASK_CONFIG_DIR/taskrc'" >&2
        return 1
    fi
}
