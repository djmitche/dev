# do a CVS checkout 
# cvs_checkout REPOSITORY MODULE DIRNAME
cvs_checkout() {
  (
    DIRNAME="${3-wip}"

    cd "$DEV_PROJECT"
    $CVS -d "$1" checkout -d "$DIRNAME" $2
  )
}
