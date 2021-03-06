DEV_SETUP_EXTENSION(cvs, ENABLE_CVS, enabled)

if $ENABLE_CVS; then
  DEV_PATH_PROGS(CVS, cvs)
  if test -z "$CVS"; then
    AC_MSG_ERROR([cvs extension enabled, but 'cvs' not found])
  fi
fi
