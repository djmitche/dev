# Default values for configuration variables

export DEV_SUBCOMMANDS_PATH="${DEV_PROJECT_DIR}/dev/subcommands"
export DEV_TASKTYPES_DIR="${DEV_PROJECT_DIR}/dev/tasks"

# Load all extensions' default values
for ext in $EXTENSIONS; do
    defaults_sh="$extbasedir/$ext/defaults.sh"
    if test -f "$defaults_sh"; then
        source "$defaults_sh" || exit 1
    fi
done
