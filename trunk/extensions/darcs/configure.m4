DEV_SETUP_EXTENSION(darcs, ENABLE_DARCS, disabled)

if $ENABLE_DARCS; then
  DEV_PATH_PROGS(DARCS, darcs)
  if test -z "$DARCS"; then
    AC_MSG_ERROR([darcs extension enabled, but 'darcs' not found])
  fi
fi
