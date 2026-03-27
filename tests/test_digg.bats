#!/usr/bin/env bats
load 'helpers'

setup() {
    setup_repo
    git remote add origin "$TEST_REPO"
    git fetch origin
    git branch --set-upstream-to=origin/master master

    # Create a file in a stash
    echo "stashed content" > stashed_file.txt
    git add stashed_file.txt
    git stash push -m "stash with file"

    # Create an unpushed commit with a different file
    echo "committed content" > committed_file.txt
    git add committed_file.txt
    git commit -m "unpushed commit"
}
teardown() { teardown_repo; }

@test "digg: finds a file in a stash" {
    run "$BIRGIT_/digg" "stashed_file.txt"
    [ "$status" -eq 0 ]
    [[ "$output" == *"stash@{0}"* ]]
}

@test "digg: finds a file in an unpushed commit" {
    run "$BIRGIT_/digg" "committed_file.txt"
    [ "$status" -eq 0 ]
    [[ "$output" =~ ^[0-9a-f]{40}$ ]]
}

@test "digg: exits zero with no output when file is not found" {
    run "$BIRGIT_/digg" "nonexistent_file.txt"
    [ "$status" -eq 0 ]
    [ -z "$output" ]
}
