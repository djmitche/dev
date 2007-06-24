dnl SYNOPSIS
dnl 
dnl     DEV_CONFIG_VAR([VARNAME])
dnl
dnl DESCRIPTION
dnl
dnl     Add VARNAME to the list of variables that will be defined in 
dnl     ${datarootdir}/dev/core/config.sh
AC_DEFUN([DEV_CONFIG_VAR], [
    AC_REQUIRE([DEV_CONFIG_VAR_OUTPUT])
    DEV_CONFIG_VARS="$DEV_CONFIG_VARS $1"
])

dnl utility function for the above
AC_DEFUN([DEV_CONFIG_VAR_OUTPUT], [
    AC_CONFIG_COMMANDS_PRE([
        # build core/config.sh.in
        CONFIG_SH_IN=core/config.sh.in
        echo '# Variables discovered at configuration time' > $CONFIG_SH_IN
        for var in $DEV_CONFIG_VARS; do
            echo "$var='@$var@'" >> $CONFIG_SH_IN
        done
    ])
    AC_CONFIG_FILES([core/config.sh])
])
