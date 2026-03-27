#!/usr/bin/env bats
load 'helpers'

setup() {
    setup_repo
    echo "v1" > file.txt
    git add file.txt && git commit -m "add file"
}
teardown() { teardown_repo; }

@test "changes: exits zero with no output when tree is clean" {
    run "$BIRGIT_/changes"
    [ "$status" -eq 0 ]
    [ -z "$output" ]
}

@test "changes: lists a modified file with absolute path" {
    echo "v2" > file.txt
    run "$BIRGIT_/changes"
    [ "$status" -eq 0 ]
    [ "$output" = "$TEST_REPO/file.txt" ]
}

@test "changes: defaults to HEAD when no argument given" {
    echo "v2" > file.txt
    run "$BIRGIT_/changes"
    [ "$status" -eq 0 ]
    [[ "$output" == *"file.txt"* ]]
}

@test "changes: accepts a commit ref argument" {
    first_commit="$(git rev-parse HEAD)"
    echo "v2" > file.txt
    git add file.txt && git commit -m "update file"
    run "$BIRGIT_/changes" "$first_commit"
    [ "$status" -eq 0 ]
    [[ "$output" == *"file.txt"* ]]
}

@test "changes: exits non-zero for unknown ref" {
    run "$BIRGIT_/changes" no-such-ref
    [ "$status" -ne 0 ]
}
