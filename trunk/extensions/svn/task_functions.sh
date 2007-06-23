# do a SVN checkout 
# svn_checkout URL [DIRECTORY]
svn_checkout() {
  $SVN co "$1" "${DEV_WIP_DIR}/${2}"
}

# unload_svn [DIRECTORY]
unload_svn() {
  dir="${DEV_WIP_DIR}/${1}"
  if [ `$SVN status "${dir}" | $WC -l` -ne "0" ]
  then
    echo "Uncommitted changes in '${dir}'; commit them or use 'svn revert'."
    return 1
  fi

  # otherwise just let it get blasted away
}

# svn_status [DIRECTORY]
svn_status() {
  dir="${DEV_WIP_DIR}/${1}"
  $SVN status "$dir"
}
