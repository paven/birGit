#!/usr/bin/env bats
load 'helpers'

setup()    { setup_repo; }
teardown() { teardown_repo; }

@test "tracks: exits non-zero with message when no upstream set" {
    run "$BIRGIT_/tracks"
    [ "$status" -ne 0 ]
    [[ "$output" == *"no upstream"* ]]
}

@test "tracks: returns upstream name when tracking branch is set" {
    # Simulate a remote by adding the repo itself as a remote
    git remote add origin "$TEST_REPO"
    git fetch origin
    git branch --set-upstream-to=origin/master master
    run "$BIRGIT_/tracks"
    [ "$status" -eq 0 ]
    [ "$output" = "origin/master" ]
}
