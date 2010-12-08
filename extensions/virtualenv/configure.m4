DEV_SETUP_EXTENSION(virtualenv, ENABLE_VIRTUALENV, enabled)

if $ENABLE_VIRTUALENV; then
  DEV_PATH_PROGS(VIRTUALENV, virtualenv)
  if test -z "$VIRTUALENV"; then
    AC_MSG_WARN([virtualenv enabled, but 'virtualenv' not found; will depend on finding 'virtualenv' in $PATH at runtime])
    VIRTUALENV=virtualenv
  fi
fi
