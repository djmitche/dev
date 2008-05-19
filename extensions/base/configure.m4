# always build this extension

EXTENSIONS="$EXTENSIONS base"
DIST_EXTENSIONS="$DIST_EXTENSIONS base"

DEV_PATH_PROGS([TAR], [gtar gnutar tar])
if test x"$TAR" = x; then
    AC_MSG_ERROR(['tar' not found])
fi

AC_CONFIG_FILES([extensions/base/Makefile])
