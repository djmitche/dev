. ./testutils.sh
setup_project

testUsage() {
    "${bindir}/dev" >test.output 2>test.output
    assertTrue \
        "bare 'dev' gives usage message" \
        "grep ^USAGE test.output >/dev/null"

    "${bindir}/dev" help >test.output 2>test.output
    assertTrue \
        "'dev help' gives usage message" \
        "grep ^USAGE test.output >/dev/null"
}

testDevProject() {
    local projdir=`pwd`
    assertSame \
        "'dev project' gives the project directory" \
        `"${bindir}/dev" project` \
        "$projdir"

    mkdir "foo"; cd "foo"
    assertSame \
        "'dev project' gives the project directory, even from a subdir" \
        `"${bindir}/dev" project` \
        "$projdir"
    cd ..

    # TODO: dev project new
    # TODO: dev project edit
}

suite() {
    suite_addTest testUsage
    suite_addTest testDevProject
}
. "${srcdir}/shunit2"
