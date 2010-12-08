# make sure the virtualenv package cache is set up
#
# Inputs:
#   VIRTUALENV_PACKAGE_CACHE
# Outputs:
#   full path to the package cache, or empty string if no cache is set up
# Side-effects:
#   package cache directory will be created if it does not exist
set_up_virtualenv_cache() {
    if test -n "${VIRTUALENV_PACKAGE_CACHE}"; then
        local pkgcache=`join_paths "${DEV_PROJECT_DIR}" "${VIRTUALENV_PACKAGE_CACHE}"`
        if ! test -d "${pkgcache}"; then
            mkdir -p "${pkgcache}" || exit 1
        fi
        echo "$pkgcache"
    fi
}
