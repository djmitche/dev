# Require specific extensions.  For each extension, source its
# 'require.sh'.
#
# Input:
#   $@: list of extensions
_LOADED_EXTENSIONS=
require() {
    local ext e already require_sh
    for ext in "$@"; do
        if test `expr "$ext" : ".*[/ ].*"` -gt 0; then
            die "Invalid extension in 'require' statement: '$ext'"
        fi

        for e in $_LOADED_EXTENSIONS; do
            if test x"$e" = x"$ext"; then
                continue 2
            fi
        done

        require_sh="$libexecdir/dev/extensions/$ext/require.sh"
        if test -f "$require_sh"; then
            # mark the extension as already loaded to prevent infinite recursion
            _LOADED_EXTENSIONS="$_LOADED_EXTENSIONS $ext"
            source "$require_sh" || die "Failed to load extension '$ext'"
        fi

    done
}
