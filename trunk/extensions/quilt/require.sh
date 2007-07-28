## functions for interfacing with quilt

export QUILT_PATCHES

# set up quilt, using the 'series' file in the task directory
# use_quilt [DIR]
use_quilt() {
  local destdir="$1"

  ( cd "$DEV_TASK_DIR"
    if test -n "$destdir"; then
      cd "$destdir"
    fi
    # quilt looks for 'patches' directory and for '.pc/series'

    test -e "${QUILT_PATCHES-patches}" && die "Task already has a patches/ directory"
    ln -s "$DEV_PATCH_DIR" "${QUILT_PATCHES-patches}"

    test -e .pc && die "Task already has a .pc/ directory"
    $MKDIR .pc

    SERIES_FILE="${DEV_TASK_CONFIG_DIR}/series"
    test -e "$SERIES_FILE" || touch "$SERIES_FILE"
    ( cd .pc; ln -s "$SERIES_FILE" series ) || exit 1

    # 'upgrade' is the easiest way to create a new, 'empty' quilt setup
    $QUILT upgrade 2>&1 > /dev/null
  ) || die "Error occurred during quilt setup"
}

# unload quilt by popping all of the patches; this will abort an unload
# if a patch does not unapply
# unload_quilt [DIR]
unload_quilt() {
  local destdir="$1"

  ( cd "$DEV_TASK_DIR"
    if test -n "$destdir"; then
      cd "$destdir"
    fi

    $QUILT pop -a
  )
  # quilt pop returns '2' if there are no patches to pop
  test $? -eq 1 && die "Could not remove all patches"

  true # signal success
}

quilt_status() {
  local destdir="$1"

  ( cd "$DEV_TASK_DIR"
    if test -n "$destdir"; then
      cd "$destdir"
    fi

    $QUILT series -v
  )
}
