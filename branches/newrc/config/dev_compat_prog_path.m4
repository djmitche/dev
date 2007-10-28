dnl SYNOPSIS
dnl
dnl     DEV_COMPAT_PROG_PATH(VARIABLE, PROG, [ALTERNATES], [EXTRA_PATHS], [TESTS])
dnl     (lifted from quilt and modified by Dustin)
dnl
dnl OVERVIEW
dnl
dnl     Allow configure to specify a specific binary.  ALTERNATES are
dnl     alternate programs that will fit the bill.  EXTRA_PATHS is
dnl     a colon-separated list of additional directories to search.
dnl
dnl     If TESTS is set, it is run after VARIABLE has been set, and can
dnl     set VARIABLE to @INTERNAL@ or call AC_MSG_ERROR if the found binary
dnl     proves unsuitable.
dnl
dnl     The result is placed in $VARIABLE, which is AC_SUBST'd and
dnl     DEV_CONFIG_VAR'd.
dnl
AC_DEFUN([DEV_COMPAT_PROG_PATH],[
  AC_REQUIRE([DEV_COMPAT_PROG_INIT])
  m4_define([internal_$2_cmd],[esyscmd(ls compat/$2.in 2>/dev/null)])

  AC_ARG_WITH($2, AC_HELP_STRING(
    [--with-$2], [name of the $2 executable to use]
                 m4_if(internal_$2_cmd,[],[],[ (use --without-$2
                          to use an internal mechanism)])),
  [
    : # $withval already set
  ],[
    withval="yes"
  ])

  case "$withval" in
    no)
      m4_if(internal_$2_cmd,[],[
        AC_MSG_ERROR([No internal implementation of $2 available])
      ], [
        $1="@INTERNAL@"
      ])
      ;;
    yes)
      AC_PATH_PROGS($1,$2 $3,,$PATH:$4)
      m4_if(internal_$2_cmd,[],[], [
        if test -z "$$1"; then
          $1="@INTERNAL@"
        fi
      ])
      ;;
    *)
      AC_MSG_CHECKING(for $2)
      $1="$withval"
      AC_MSG_RESULT([given: $withval])
      ;;
  esac

  m4_if($5, [], [], [
    if test -n "$$1" && test x"$$1" != x"@INTERNAL@"; then
      $5
    fi
  ])

  m4_if(internal_$2_cmd,[],[], [
    if test x"$$1" = x"@INTERNAL@"; then
      COMPAT_PROGRAMS="$2 $COMPAT_PROGRAMS"
      $1="$libexecdir/dev/compat/$2"
      AC_CONFIG_FILES([compat/$2])
      AC_MSG_WARN([  (will use internal implementation of $2)])
    fi
  ])

  DEV_CONFIG_VAR($1)
  AC_SUBST($1)
])

AC_DEFUN([DEV_COMPAT_PROG_INIT],[
  AC_SUBST(COMPAT_PROGRAMS)
])
