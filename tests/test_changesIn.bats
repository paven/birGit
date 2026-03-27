#!/usr/bin/env bats
load 'helpers'

setup() {
    setup_repo
    echo "v1" > file_a.txt
    echo "v1" > file_b.txt
    git add file_a.txt && git commit -m "add file_a"
    git add file_b.txt && git commit -m "add file_b"
}
teardown() { teardown_repo; }

@test "changesIn: lists file changed in HEAD commit" {
    run "$BIRGIT_/changesIn" HEAD
    [ "$status" -eq 0 ]
    [ "$output" = "$TEST_REPO/file_b.txt" ]
}

@test "changesIn: lists file changed in parent commit" {
    run "$BIRGIT_/changesIn" HEAD~1
    [ "$status" -eq 0 ]
    [ "$output" = "$TEST_REPO/file_a.txt" ]
}

@test "changesIn: output paths are absolute" {
    run "$BIRGIT_/changesIn" HEAD
    [ "$status" -eq 0 ]
    [[ "$output" == /* ]]
}

@test "changesIn: exits non-zero for unknown ref" {
    run "$BIRGIT_/changesIn" no-such-ref
    [ "$status" -ne 0 ]
}
