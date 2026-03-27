#!/usr/bin/env bats
load 'helpers'

setup() {
    setup_repo
    echo "a" > file_a.txt
    echo "b" > file_b.txt
    git add file_a.txt file_b.txt && git commit -m "add files"
}
teardown() { teardown_repo; }

# --- ignore ---

@test "ignore: marks a single file as assume-unchanged" {
    "$BIRGIT_/ignore" file_a.txt
    run "$BIRGIT_/ignored"
    [[ "$output" == *"file_a.txt"* ]]
}

@test "ignore: marks multiple files in one call" {
    "$BIRGIT_/ignore" file_a.txt file_b.txt
    run "$BIRGIT_/ignored"
    [[ "$output" == *"file_a.txt"* ]]
    [[ "$output" == *"file_b.txt"* ]]
}

@test "ignore: exits non-zero for untracked file" {
    run "$BIRGIT_/ignore" nonexistent.txt
    [ "$status" -ne 0 ]
}

# --- unignore ---

@test "unignore: clears assume-unchanged flag" {
    git update-index --assume-unchanged file_a.txt
    "$BIRGIT_/unignore" file_a.txt
    run "$BIRGIT_/ignored"
    [[ "$output" != *"file_a.txt"* ]]
}

@test "unignore: clears flag on multiple files" {
    git update-index --assume-unchanged file_a.txt file_b.txt
    "$BIRGIT_/unignore" file_a.txt file_b.txt
    run "$BIRGIT_/ignored"
    [ -z "$output" ]
}
