#!/usr/bin/env bats
load 'helpers'

setup()    { setup_repo; }
teardown() { teardown_repo; }

@test "branch: returns current branch name" {
    run "$BIRGIT_/branch"
    [ "$status" -eq 0 ]
    [ "$output" = "master" ]
}

@test "branch: reflects checked-out branch" {
    git checkout -b feature-x
    run "$BIRGIT_/branch"
    [ "$status" -eq 0 ]
    [ "$output" = "feature-x" ]
}

@test "branch: exits non-zero outside a git repo" {
    cd /tmp
    run "$BIRGIT_/branch"
    [ "$status" -ne 0 ]
}
