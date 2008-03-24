installchecks = basic.tst
testutils = testutils.sh

# perform autoconf substitution on various files
PREFIXES = .in .sh .tst
.sh.tst:
	$(top_builddir)/config.status --file=$@:$<
	chmod +x $@

.in.sh:
	$(top_builddir)/config.status --file=$@:$<

installcheck-local: $(installchecks) $(testutils)
	@for ic in $(installchecks); do \
		srcdir="$(srcdir)" ./$$ic || exit 1; \
	done
