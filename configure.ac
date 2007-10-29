# Process this file with autoconf to produce a configure script.
# (Skeleton of this file lifted from quilt by Dustin)
AC_INIT([dev], [0.3], [dustin@cs.uchicago.edu])
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
EXTENSIONS=""
DIST_EXTENSIONS=""

# autogen sets this up to include all extensions/*/configure.m4 files.
m4_include(extensions/configure.m4)

DEV_CONFIG_VAR(EXTENSIONS)
AC_SUBST(EXTENSIONS)
AC_SUBST(DIST_EXTENSIONS)

# special directories
DEV_DEFINE_DIR(frameworklibdir, "${libexecdir}/dev/framework")
DEV_DEFINE_DIR(subcommanddir, "${libexecdir}/dev/subcommands")
DEV_DEFINE_DIR(loaderdir, "${libexecdir}/dev/loader")
DEV_DEFINE_DIR(extbasedir, "${libexecdir}/dev/extensions")

# final output

AC_CONFIG_FILES([
    Makefile
    framework/dev
    framework/Makefile
    compat/Makefile
    extensions/Makefile
])

AC_OUTPUT

# Print results
AC_MSG_RESULT([$PACKAGE_NAME version $PACKAGE_VERSION configured.])
AC_MSG_RESULT([      Installation Prefix: $prefix])
AC_MSG_RESULT([               Extensions: $EXTENSIONS])
if test -n "$COMPAT_PROGRAMS"; then
  AC_MSG_RESULT([   Compatibility Programs: $COMPAT_PROGRAMS])
fi
