dnl SYNOPSIS
dnl
dnl     DEV_PATH_PROGS(..)
dnl
dnl OVERVIEW
dnl
dnl     Just like AC_PATH_PROGS, but the variable is also added to 
dnl     the config with DEV_CONFIG_VAR.
dnl
AC_DEFUN([DEV_PATH_PROGS],[
  AC_PATH_PROGS($1,$2,$3,$4)
  DEV_CONFIG_VAR($1)
])

AC_DEFUN([DEV_COMPAT_PROG_INIT],[
  AC_SUBST(COMPAT_PROGRAMS)
])
