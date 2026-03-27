#!/usr/bin/env bats
load 'helpers'

setup()    { setup_repo; }
teardown() { teardown_repo; }

@test "save: stashes working directory changes" {
    echo "dirty" > file.txt
    git add file.txt
    run "$BIRGIT_/save" "my stash"
    [ "$status" -eq 0 ]
    [ ! -f file.txt ]
}

@test "save: stash message is recorded" {
    echo "dirty" > file.txt
    git add file.txt
    "$BIRGIT_/save" "my stash message"
    run git stash list
    [[ "$output" == *"my stash message"* ]]
}

@test "save: stash message with spaces is preserved" {
    echo "dirty" > file.txt
    git add file.txt
    "$BIRGIT_/save" "multi word message"
    run git stash list
    [[ "$output" == *"multi word message"* ]]
}
