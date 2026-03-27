#!/usr/bin/env bats
load 'helpers'

setup()    { setup_repo; }
teardown() { teardown_repo; }

@test "new: exits zero with no output when there are no untracked files" {
    run "$BIRGIT_/new"
    [ "$status" -eq 0 ]
    [ -z "$output" ]
}

@test "new: lists an untracked file with its absolute path" {
    echo "hello" > untracked.txt
    run "$BIRGIT_/new"
    [ "$status" -eq 0 ]
    [ "$output" = "$TEST_REPO/untracked.txt" ]
}

@test "new: does not list a tracked file" {
    echo "hello" > tracked.txt
    git add tracked.txt && git commit -m "add file"
    run "$BIRGIT_/new"
    [ "$status" -eq 0 ]
    [ -z "$output" ]
}

@test "new: lists untracked file when called from subdirectory" {
    echo "hello" > untracked.txt
    mkdir -p sub && cd sub
    run "$BIRGIT_/new"
    [ "$status" -eq 0 ]
    [ "$output" = "$TEST_REPO/untracked.txt" ]
}
