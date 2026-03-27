#!/usr/bin/env bats
load 'helpers'

setup()    { setup_repo; }
teardown() { teardown_repo; }

@test "ignored: exits zero with no output when nothing is ignored" {
    run "$BIRGIT_/ignored"
    [ "$status" -eq 0 ]
    [ -z "$output" ]
}

@test "ignored: lists a file marked assume-unchanged" {
    echo "content" > tracked.txt
    git add tracked.txt && git commit -m "add file"
    git update-index --assume-unchanged tracked.txt
    run "$BIRGIT_/ignored"
    [ "$status" -eq 0 ]
    [[ "$output" == *"tracked.txt"* ]]
}

@test "ignored: does not list a normal tracked file" {
    echo "content" > tracked.txt
    git add tracked.txt && git commit -m "add file"
    run "$BIRGIT_/ignored"
    [ "$status" -eq 0 ]
    [[ "$output" != *"tracked.txt"* ]]
}
