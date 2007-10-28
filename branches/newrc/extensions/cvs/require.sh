# do a CVS checkout 
# cvs_checkout REPOSITORY MODULE DIRNAME
cvs_checkout() {
    local repo module dirname parentdir
    parentdir="$DEV_TASK_DIR"
    repo="$1"
    module="$2"
    codir="$3"

    test $# -eq 3 || die "cvs_checkout requires three arguments"

    # cvs doesn't handle checking out to '.' properly, so fake it.
    if test "$codir" = "."; then
        codir=`$BASENAME $parentdir`
        parentdir=`$DIRNAME $parentdir`
    fi

    (
        cd "$parentdir"
        $CVS -d "$repo" checkout -d "$codir" "$module"
    )
}
