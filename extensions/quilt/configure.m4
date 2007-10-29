DEV_SETUP_EXTENSION(quilt, ENABLE_QUILT, disabled)

if $ENABLE_QUILT; then
  DEV_COMPAT_PROG_PATH(QUILT, quilt)
  if test -z "$QUILT"; then
    AC_MSG_ERROR([quilt extension enabled, but 'quilt' not found])
  fi
fi
