# Default values for configuration variables

export DEV_SUBCOMMANDS_PATH="${DEV_PROJECT_DIR}/dev/subcommands"
export DEV_TASKS_DIR="${DEV_PROJECT_DIR}/dev/tasks"

# Load all extensions' default values
for ext in $EXTENSIONS; do
    defaults_sh="$libexecdir/dev/extensions/$ext/defaults.sh"
    if test -f "$defaults_sh"; then
        source "$defaults_sh" || exit 1
    fi
done
