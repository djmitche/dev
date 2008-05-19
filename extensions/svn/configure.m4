DEV_SETUP_EXTENSION(svn, ENABLE_SVN, enabled)

if $ENABLE_SVN; then
  DEV_PATH_PROGS(SVN, svn)
  if test -z "$SVN"; then
    AC_MSG_ERROR([svn extension enabled, but 'svn' not found])
  fi
fi
