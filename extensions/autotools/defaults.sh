# The build directory, where compilation will take place
export AUTOTOOLS_BUILD_DIR=${DEV_PROJECT_DIR}/tmp/build
add_interesting_variable AUTOTOOLS_BUILD_DIR

# The --prefix passed to ./configure
export AUTOTOOLS_PREFIX_DIR=${DEV_PROJECT_DIR}/tmp/prefix
add_interesting_variable AUTOTOOLS_PREFIX_DIR

# command to run to set up a directory for autotools (e.g., 'autogen')
# if you need more than one command here, define a shell function and
# put its name in AUTOTOOLS_SETUP.
autotools_setup_default() {
    cd $DEV_TASK_DIR
    for candidate in autogen autogen.sh; do
        if test -x $candidate; then
            ./$candidate || exit 1
            break
        fi
    done
}
export AUTOTOOLS_SETUP=autotools_setup_default
add_interesting_variable AUTOTOOLS_SETUP

# ./configure flags
export AUTOTOOLS_CONFIGURE_FLAGS=
add_interesting_variable AUTOTOOLS_CONFIGURE_FLAGS

# ./configure script (useful if the script is in a subdirectory)
export AUTOTOOLS_CONFIGURE_COMMAND=configure
add_interesting_variable AUTOTOOLS_CONFIGURE_COMMAND
