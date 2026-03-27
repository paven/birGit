#!/usr/bin/env bats
load 'helpers'

setup()    { setup_repo; }
teardown() { teardown_repo; }

@test "root: returns repo root when called from root" {
    run "$BIRGIT_/root"
    [ "$status" -eq 0 ]
    [ "$output" = "$TEST_REPO" ]
}

@test "root: returns repo root when called from subdirectory" {
    mkdir -p sub/dir
    cd sub/dir
    run "$BIRGIT_/root"
    [ "$status" -eq 0 ]
    [ "$output" = "$TEST_REPO" ]
}

@test "root: exits non-zero outside a git repo" {
    cd /tmp
    run "$BIRGIT_/root"
    [ "$status" -ne 0 ]
}
