## functions for interfacing with quilt

# set up quilt, using the 'series' file in the task directory
# use_quilt 
use_quilt() {
  ( cd $DEV_WIP_DIR
    # quilt looks for 'patches' directory and for '.pc/series'
    # TODO this is a cheap way out:
    [ -e patches ] && die "Project already has a patches/ directory"
    $LN -s $DEV_PATCH_DIR patches

    $MKDIR .pc
    [ -e .dev/task/series ] || $TOUCH .dev/task/series
    $LN -s ../.dev/task/series .pc/series

    # 'upgrade' is the easiest way to create a new, 'empty' quilt setup
    $QUILT upgrade 2>&1 > /dev/null
  ) || die "Error occurred during quilt setup"
}

# unload quilt by popping all of the patches; this will abort an unload
# if a patch does not unapply
# unload_quilt
unload_quilt() {
  ( cd $DEV_WIP_DIR
    $QUILT pop -a
  )
  # quilt pop returns '2' if there are no patches to pop
  [ $? = "1" ] && die "Could not remove all patches"
  true # signal success
}

quilt_status() {
  ( cd $DEV_WIP_DIR
    $QUILT applied && echo ' -- working here -- ' && quilt unapplied
  )
}
