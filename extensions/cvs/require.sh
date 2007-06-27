# do a CVS checkout 
# cvs_checkout REPOSITORY MODULE DIRNAME
cvs_checkout() {
  (
    $CVS -d "$1" checkout -d "$DEV_TASK_DIR/$3" "$2"
  )
}
