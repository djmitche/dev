DEV_SETUP_EXTENSION(hg, ENABLE_HG, disabled)

if $ENABLE_HG; then
  DEV_PATH_PROGS(HG, hg)
  if test -z "$HG"; then
    AC_MSG_ERROR([hg extension enabled, but 'hg' not found])
  fi
fi
