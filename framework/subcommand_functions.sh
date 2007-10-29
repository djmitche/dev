####
## Error handling

# die with an error message sent to standard error
#
# Input:
#  - $@: message
# Side-effect:
#  - does not return
die() {
  echo "$@" >&2
  exit 1
}

# issue a short warning before doing something harmful
#
# Input:
#  - $@: message
# Side-effect:
#  - text output to stderr
warning_countdown() {
  echo "WARNING: $@" >&2
  echo -ne "Three seconds to abort: " >&2
  for x in 3 ... 2 ... 1 ...; do
    # XXX is this a compatible invocation of 'echo'?
    echo -ne "$x " >&2
    # XXX is this compatible?
    LC_ALL=C sleep .5
  done
  echo 'proceeding!' >&2
}

# Join two paths.  If the second path is relative, it is taken
# relative to the first.  If it is absolute, then it is returned
# intact.
#
# input:
#  - $1: base directory (should be absolute)
#  - $2: potentially relative directory
# output:
#  - stdout: absolute path
join_paths() {
    local absolute_dir="$2"
    # TODO: convert to use 'expr'; ${..:..:..} is not portable
    if test x"${absolute_dir:0:1}" != x"/"; then
        absolute_dir="$1/$absolute_dir"
    fi
    echo "$absolute_dir"
}
