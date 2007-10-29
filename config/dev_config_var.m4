dnl SYNOPSIS
dnl 
dnl     DEV_CONFIG_VAR([VARNAME])
dnl
dnl DESCRIPTION
dnl
dnl     Add VARNAME to the list of variables that will be defined in 
dnl     ${datarootdir}/dev/framework/config.sh.
AC_DEFUN([DEV_CONFIG_VAR], [
    AC_REQUIRE([DEV_CONFIG_VAR_OUTPUT])
    m4_append([DEV_CONFIG_VAR_vars], $1, [ ])
])

dnl utility function for the above
AC_DEFUN([DEV_CONFIG_VAR_OUTPUT], [
    dnl start with all of the installation directories.  Note that prefix
    dnl and exec_prefix should come first
    m4_define([DEV_CONFIG_VAR_vars], [
        prefix exec_prefix
        bindir datadir datarootdir docdir dvidir
        htmldir includedir infodir libdir libexecdir localedir
        localstatedir mandir onlyincludedir pdfdir
        psdir sbindir sharedstatedir sysconfdir
        ])
    AC_CONFIG_COMMANDS([framework/config.sh], [
        (   
dnl whitespace is important here!
m4_foreach_w(dcv, DEV_CONFIG_VAR_vars, 
[           echo dcv=\"$dcv\"
])
        ) > $ac_abs_builddir/config.sh
    ],[
dnl whitespace is important here!
m4_foreach_w(dcv, DEV_CONFIG_VAR_vars, 
[dcv='$dcv'
])
    ])
])
