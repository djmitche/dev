# Default values for configuration variables

export DEV_SUBCOMMANDS_PATH="${DEV_PROJECT_DIR}/dev/subcommands"
export DEV_LOADER_PATH="${DEV_PROJECT_DIR}/dev/loaders"
export DEV_TASKTYPES_DIR="${DEV_PROJECT_DIR}/dev/tasks"

# gather up interesting variables
dev_interesting_extension_variables=''
add_interesting_variable() {
    dev_interesting_extension_variables="${dev_interesting_extension_variables} $@"
}

# Load all extensions' default values
for ext in $EXTENSIONS; do
    defaults_sh="$extbasedir/$ext/defaults.sh"
    if test -f "$defaults_sh"; then
        source "$defaults_sh" || exit 1
    fi
done
