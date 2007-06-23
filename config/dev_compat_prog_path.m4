dnl (lifted from quilt by Dustin)
dnl Allow configure to specify a specific binary
dnl 1: Environment variable
dnl 2: binary name
dnl 3: optional list of alternatives
AC_DEFUN([DEV_COMPAT_PROG_PATH],[
  m4_define([internal_$2_cmd],[esyscmd(ls compat/$2.in 2>/dev/null)])

  AC_ARG_WITH($2, AC_HELP_STRING(
    [--with-$2], [name of the $2 executable to use]
                 m4_if(internal_$2_cmd,[],[],[ (use --without-$2
                          to use an internal mechanism)])),
  [
    if test x"$withval" = xnone; then
      AC_MSG_ERROR([Invalid configure argument.  use --without-$2])
    fi
    AC_MSG_CHECKING(for $2)
    if test x"$withval" != xno; then
      $1="$withval"
      if test -e "$$1"; then
	if test ! -f "$$1" -a ! -h "$$1" || test ! -x "$$1"; then
	  AC_MSG_ERROR([$$1 is not an executable file])
	fi
      fi
      AC_MSG_RESULT([$$1])
      if test ! -e "$$1"; then
        AC_MSG_WARN([$$1 does not exist])
      fi
      COMPAT_SYMLINKS="$COMPAT_SYMLINKS $2"
    fi
  ],[
    m4_if([$3],[],[
      AC_PATH_PROG($1,$2,,$PATH:$4)
    ],[
      AC_PATH_PROGS($1,$3,,$PATH:$4)
      if test `expr "$$1" : '.*/\([[^/]]*\)$'` != "$2"; then
	COMPAT_SYMLINKS="$COMPAT_SYMLINKS $2"
      fi
    ])
    m4_if([$4],[],[],[
      if test -n "$$1"; then
	as_save_IFS=$IFS; IFS=$PATH_SEPARATOR
        for dir in "$4"; do
          if test "`dirname $$1`" = "$dir"; then
            COMPAT_SYMLINKS="$COMPAT_SYMLINKS $2"
	    break
	  fi
        done
	IFS="$as_save_IFS"
      fi
    ])
  ])
  if test -z "$$1"; then
    m4_if(internal_$2_cmd,[],[
      AC_MSG_ERROR([Please specify the location of $2 with the option '--with-$2'])
    ],[
      AC_MSG_WARN([Using internal $2 mechanism.  Use option '--with-$2' to override])
      COMPAT_PROGRAMS="$COMPAT_PROGRAMS $2"
      $1=$2
      INTERNAL_$1=1
    ])
  fi
  AC_SUBST($1)
])
