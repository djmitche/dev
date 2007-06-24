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

