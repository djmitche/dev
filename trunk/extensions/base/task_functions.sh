# -------- base task functions

# copy a directory from somewhere else
# copy_directory DIRECTORY
copy_directory() {
  $TAR -C $1 --exclude CVS --exclude .svn --exclude .dev -cf - . | tar -C $DEV_WIP_DIR -xf -
}

