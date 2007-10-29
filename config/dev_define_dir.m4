# SYNOPSIS
# 
#     DEV_DEFINE_DIR([VARNAME], [VALUE])
#
# DESCRIPTION
#
#     Like AC_DEFINE_DIR, but evaluates VALUE instead of assuming it's
#     a variable, and calls DEV_CONFIG_VAR on the result.
AC_DEFUN([DEV_DEFINE_DIR], [
    $1=$2
    AC_DEFINE_DIR($1, $1)
    DEV_CONFIG_VAR($1)
])
