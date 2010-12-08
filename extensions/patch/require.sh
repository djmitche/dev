# useful mkpatch methods

# mkpatch function to show just the HEAD revision
mkpatch_git_single() {
    $GIT show HEAD
}

# mkpatch function to run a simple 'svn diff' in the task directory,
# making a patch of all uncommitted changes
mkpatch_svn_diff() {
    $SVN diff
}

# mkpatch function to run a simple 'hg diff' in the task directory,
# making a patch of all uncommitted changes
mkpatch_hg_diff() {
    $HG diff
}

# mkpatch function to run 'hg qdiff' in the task directory, making a patch of
# the changes in the mq series
mkpatch_hg_mq_qdiff() {
    $HG qdiff
}

# Run the selected mkpatch method.  This is provided so that other extensions
# can use it, e.g., to upload for code review
#
# Input:
#  User's command-line arguments
# Output:
#  patch file
do_mkpatch() {
    # the job is pretty simple, actually: just invoke the patch-making function
    ( cd "$DEV_TASK_DIR" && "mkpatch_${MKPATCH_PATCH_METHOD}" "${@}" )
}
