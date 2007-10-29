# Process this file with autoconf to produce a configure script.
# (Skeleton of this file lifted from quilt by Dustin)
AC_INIT([dev], [0.2-dev], [dustin@cs.uchicago.edu])
AC_CONFIG_AUX_DIR(config)
AC_CONFIG_SRCDIR(configure.ac)
AM_INIT_AUTOMAKE

PACKAGE_RELEASE=1
AC_SUBST(PACKAGE_RELEASE)

AC_PROG_INSTALL

AC_SYS_INTERPRETER
if test "$interpval" != yes ; then
	AC_MSG_WARN([no

bash/perl scripts may not be invoked correctly due to problems with your
system's implementation of #! being either broken or non-existant.
])
fi

# check for programs, potentially substituting
# local compatible versions
unset BASH  # bash sets this itself!
DEV_COMPAT_PROG_PATH(BASH, bash)
DEV_COMPAT_PROG_PATH(GREP, grep)
DEV_COMPAT_PROG_PATH(COLUMN, column)
DEV_COMPAT_PROG_PATH(MKTEMP, mktemp)
DEV_COMPAT_PROG_PATH(FIND, find)
DEV_COMPAT_PROG_PATH(DATE, date)
DEV_COMPAT_PROG_PATH(SORT, sort)
DEV_COMPAT_PROG_PATH(SED, sed)
DEV_COMPAT_PROG_PATH(MKDIR, mkdir, [], [], [
   if ! $MKDIR -p conftest-dir/subdir >/dev/null 2>&1; then
       AC_MSG_ERROR([Your 'mkdir' does not support the '-p' option])
   fi
])
DEV_COMPAT_PROG_PATH(DIRNAME, dirname)
DEV_COMPAT_PROG_PATH(BASENAME, basename)
DEV_COMPAT_PROG_PATH(WC, wc)

# extensions

ENABLE_CVS=true
AC_ARG_ENABLE(cvs, AC_HELP_STRING(
    [--disable-cvs], [Disable CVS extension (default enabled)]),
    [if test "x$enableval" = "xno"; then ENABLE_CVS=false; fi])
if $ENABLE_CVS; then
  DEV_COMPAT_PROG_PATH(CVS, cvs)
fi

ENABLE_SVN=true
AC_ARG_ENABLE(svn, AC_HELP_STRING(
    [--disable-svn], [Disable SVN extension (default enabled)]),
    [if test "x$enableval" = "xno"; then ENABLE_SVN=false; fi])
if $ENABLE_SVN; then
  DEV_COMPAT_PROG_PATH(SVN, svn)
fi

ENABLE_QUILT=true
AC_ARG_ENABLE(quilt, AC_HELP_STRING(
    [--disable-cvs], [Disable Quilt extension (default enabled)]),
    [if test "x$enableval" = "xno"; then ENABLE_QUILT=false; fi])
if $ENABLE_QUILT; then
  DEV_COMPAT_PROG_PATH(QUILT, quilt)
fi


EXTENSIONS="base"
if $ENABLE_CVS; then EXTENSIONS="$EXTENSIONS cvs"; fi
if $ENABLE_SVN; then EXTENSIONS="$EXTENSIONS svn"; fi
if $ENABLE_QUILT; then EXTENSIONS="$EXTENSIONS quilt"; fi
DEV_CONFIG_VAR(EXTENSIONS)
AC_SUBST(EXTENSIONS)

# special directories
DEV_DEFINE_DIR(frameworklibdir, "${libexecdir}/dev/framework")
DEV_DEFINE_DIR(subcommandsdir, "${libexecdir}/dev/subcommands")
DEV_DEFINE_DIR(loaderdir, "${libexecdir}/dev/loader")
DEV_DEFINE_DIR(extbasedir, "${libexecdir}/dev/extensions")

# final output

AC_CONFIG_FILES([Makefile framework/Makefile compat/Makefile extensions/Makefile extensions/base/Makefile extensions/cvs/Makefile extensions/svn/Makefile extensions/quilt/Makefile])
AC_CONFIG_FILES([framework/dev])

AC_OUTPUT

# Print results
AC_MSG_RESULT([$PACKAGE_NAME version $PACKAGE_VERSION configured.])
AC_MSG_RESULT([      Installation Prefix: $prefix])
AC_MSG_RESULT([               Extensions: $EXTENSIONS])
if test -n "$COMPAT_PROGRAMS"; then
  AC_MSG_RESULT([   Compatibility Programs: $COMPAT_PROGRAMS])
fi
