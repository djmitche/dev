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
        if test -f "$1" ; then
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
# Output:
#  - set $DEV_PROJECT_DIR (exported) to the project directory
#  - exit status '1' on error
set_project_dir() {
    export DEV_PROJECT_DIR=`search_up_dir_tree .devrc`
}

# Enumerate files in a :-separated FOO_PATH variable, with a default
#
# Input:
#  $1 = :-separated path
#  $2 = default path
# Output:
#  newline-separated list of matching files on stdout
enumerate_files() {
    local old_IFS="$IFS"
    local amended_path="$1:$2"
    IFS=':'
    for dir in $amended_path; do
        test -z "$dir" && continue
        for file in $dir/*; do
            if test -f $file; then
                echo ${file##$dir/}
            fi
        done
    done
    IFS="$old_IFS"
}

# Given a filename and a :-separated list of directories, find the
# qualified path to the given file
#
# Input:
#  $1: file name
#  $2: :-separated list of directories
#  $3: default path
# Output:
#  full path to file on stdout, or empty string if not found
find_file() {
    local target="$1"
    local old_IFS="$IFS"
    local amended_path="$2:$3"
    IFS=':'
    for dir in $amended_path; do
        if test -f $dir/$target; then
            echo $dir/$target
            break
        fi
    done
    IFS="$old_IFS"
}

# Enumerate available subcommands
#
# Input:
#  $DEV_SUBCOMMANDS_PATH
# Output:
#  newline-separated list of matching files on stdout
enumerate_subcommands() {
    echo 'help' # (internal command)
    enumerate_files "$DEV_SUBCOMMANDS_PATH" "$libexecdir/dev/subcommands"
}

# Given a bare subcommand name, find the full path to its implementation.
#
# Input:
#  $1: subcommand name
#  $DEV_SUBCOMMANDS_PATH
# Output:
#  full path to subcommand on stdout, or empty string if not found
find_subcommand() {
    find_file "$1" "$DEV_SUBCOMMANDS_PATH" "$libexecdir/dev/subcommands"
}

# Find a loader implementation, given its name
#
# Input:
#  $1: loader name
#  $DEV_LOADERS_PATH
# Output:
#  full path to loader on stdout, or empty string if not found
find_loader() {
    find_file "$1" "$DEV_LOADER_PATH" "$loaderdir"
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

# Source the current project's configuration
#
# Input:
#  - $DEV_PROJECT_DIR
# Side-effects:
#  - project-specific configuration is loaded
#  - error message to stderr on error
# Output:
#  - return status of 1 if the sourcing failed
source_project_configuration() {
    if test -n "$DEV_PROJECT_DIR"; then 
        source "$DEV_PROJECT_DIR/.devrc" || return 1
    fi
}

# Source the current task, if $DEV_TASK_DIR is defined.
#
# Input:
#  - $DEV_TASK_DIR
# Side-effects:
#  - extensions are loaded by the 'require' function
#  - tasktype configuration is loaded
#  - task functions are defined
#  - error messages go to stderr on error
#  - .task may be upgraded if necessary
# Output:
#  - return status of 1 if the sourcing failed
#  - sets $DEV_TASKTYPE (exported) if a task is defined
source_task_configuration() {
    local task_file="$DEV_TASK_DIR/.task"
    local tasktype
    local config_file
    if test -z "$DEV_TASK_DIR"; then
        return;
    fi

    if test ! -f "$task_file"; then
        echo "Task file not found!" >&2
        return 1
    fi

    # upgrade .task from dev-0.4 format to dev-0.5
    if test `wc -w <"$task_file"` = "1"; then
        # a single-word file is a tasktype
        echo "Upgrading '$task_file' from dev-0.4 format" >&2
        tasktype=`<"$task_file"`
        echo "tasktype $tasktype" > "$task_file" \
            || die "Upgrade failed"
    fi

    # define the 'tasktype' function
    tasktype() {
        if test "$#" != "1"; then
            echo "Invalid 'tasktype' syntax" >&2
            return 1
        fi
        if test -n "$DEV_TASKTYPE"; then
            echo "Only one 'tasktype' declaration is allowed" >&2
            return 1
        fi

        export DEV_TASKTYPE="$1"
        local tasktype_file="$DEV_TASKTYPES_DIR/$DEV_TASKTYPE.dev"
        if test ! -f "$tasktype_file"; then
            echo "No such tasktype '$DEV_TASKTYPE'" >&2
            return 1
        fi

        # source it up
        if . "$tasktype_file"; then
            : # all good
        else
            echo "Tasktype configuration failed" >&2
            echo "Edit '$tasktype_file' manually to fix its syntax and try again" >&2
            return 1
        fi

        true
    }

    # source the configuration
    DEV_TASKTYPE=''
    if . "$task_file"; then
        : # all good
    else
        echo "Task configuration failed" >&2
        echo "Edit '$task_file' manually to fix its syntax and try again" >&2
        return 1
    fi

    test -n "$DEV_TASKTYPE" || {
        echo "No tasktype defined in '$task_file'" >&2
        return 1
    }
}
