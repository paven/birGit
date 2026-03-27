#!/usr/bin/env bats
load 'helpers'

setup() {
    setup_repo
    echo "dirty" > file.txt
    git add file.txt
}
teardown() { teardown_repo; }

@test "trash: stashes changes and prints advisory when mode is not full" {
    run "$BIRGIT_/trash"
    [ "$status" -eq 0 ]
    [ ! -f file.txt ]
    stash_count=$(git stash list | wc -l | tr -d ' ')
    [ "$stash_count" -eq 1 ]
    [[ "$output" == *"stash only"* ]]
}

@test "trash: stash is labelled trash" {
    "$BIRGIT_/trash"
    run git stash list
    [[ "$output" == *"trash"* ]]
}

@test "trash: full mode hard-resets and cleans after stashing" {
    git config birgit.trash full
    echo "untracked" > untracked.txt
    run "$BIRGIT_/trash"
    [ "$status" -eq 0 ]
    [ ! -f file.txt ]
    [ ! -f untracked.txt ]
    stash_count=$(git stash list | wc -l | tr -d ' ')
    [ "$stash_count" -eq 1 ]
}
