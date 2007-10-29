# The build directory, where compilation will take place
export AUTOTOOLS_BUILD_DIR=${DEV_PROJECT_DIR}/tmp/build

# The --prefix passed to ./configure
export AUTOTOOLS_PREFIX_DIR=${DEV_PROJECT_DIR}/tmp/prefix

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

# ./configure flags
export AUTOOTLS_CONFIGURE_FLAGS=

# ./configure script (useful if the script is in a subdirectory
export AUTOTOOLS_CONFIGURE_COMMAND=configure
