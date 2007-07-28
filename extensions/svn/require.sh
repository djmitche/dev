# do a SVN checkout 
# svn_checkout URL [DIRECTORY]
svn_checkout() {
  local url="${1}"
  local dir="${2}"
  if test -z "${SVN_CACHE_DIR}"; then
    $SVN co "$url" "${DEV_TASK_DIR}/$dir" || die "Could not check out $url"
  else
    local url_safe=`echo $url|tr -c '[:alnum:]' '-'`
    local absolute_dir="${SVN_CACHE_DIR}"
    if test "${absolute_dir:0:1}" != "/"; then
        absolute_dir="${DEV_PROJECT_DIR}/$absolute_dir"
    fi
    local cache_dir="${absolute_dir}/$url_safe"

    trap "rm -rf \"$cache_dir\"; die \"Interrupted\"" INT QUIT
    if test -d "$cache_dir"; then
      # try updating it; if we see an error, blow it away and try a new checkout
      svn up "$cache_dir" || rm -rf "$cache_dir"
    fi

    if test ! -d "$cache_dir"; then
      $SVN co "$url" "$cache_dir" || die "Could not check out $url"
    fi
    trap - INT QUIT

    # use 'tar' to copy .. it's better behaved than 'cp'
    ( cd "$cache_dir" && tar -cf - . ) | ( cd "$dir" && tar -xf - )
  fi
}

# unload_svn [DIRECTORY]
svn_unload() {
  dir="${DEV_TASK_DIR}/${1}"
  if test `$SVN status "${dir}" | $WC -l` -ne "0"
  then
    echo "Uncommitted changes in '${dir}'; commit them or use 'svn revert'."
    return 1
  fi

  # otherwise just let it get blasted away
  true
}

# (compatiblity with older name; do not use)
unload_svn() {
    svn_unload "$@"
}

# svn_status [DIRECTORY]
svn_status() {
  dir="${DEV_TASK_DIR}/${1}"
  $SVN status "$dir"
}
