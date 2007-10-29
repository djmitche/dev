# SYNOPSIS
# 
#   DEV_SETUP_EXTENSION([EXTNAME], [VARNAME], [DEFAULT])
#
# DESCRIPTION
#
#   Set up extension EXTNAME.  That involves:
#    - an --enable-EXTNAME or --disable-EXTNAME option
#    - adding EXTNAME to EXTENSIONS if it's enabled
#    - adding EXTNAME to DIST_EXTENSIONS
#    - adding extensions/EXTNAME/Makefile to AC_CONFIG_FILES
#
#   VARNAME is the name of a variable that will contain true or false
#   depending on whether the extension is enabled; it's usually 
#   ENABLE_FOO.
#
#   If DEFAULT is 'enabled', the extension is enabled by default;
#   if it's 'disabled', the extension is disabled by default.
AC_DEFUN([DEV_SETUP_EXTENSION], [
    m4_if($3, [enabled], [
        $2=true
        AC_ARG_ENABLE($1, AC_HELP_STRING(
            [--disable-$1], [Disable $1 extension]),
            [if test "x$enableval" = "xno"; then $2=false; fi])
    ], [
        $2=false
        AC_ARG_ENABLE($1, AC_HELP_STRING(
            [--enable-$1], [Enable $1 extension]),
            [if test "x$enableval" = "xyes"; then $2=true; fi])
    ])

    DIST_EXTENSIONS="$DIST_EXTENSIONS $1"

    if $$2; then
        EXTENSIONS="$EXTENSIONS $1"
    fi

    AC_CONFIG_FILES([extensions/$1/Makefile])
])
