DEV_SETUP_EXTENSION(git, ENABLE_GIT, enabled)

if $ENABLE_GIT; then
  DEV_PATH_PROGS(GIT, git)
  if test -z "$GIT"; then
    AC_MSG_ERROR([git extension enabled, but 'git' not found])
  fi
fi
