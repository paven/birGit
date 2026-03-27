#!/usr/bin/env bats
load 'helpers'

setup() {
    setup_repo
    git commit --allow-empty -m "second"
    git commit --allow-empty -m "third"
}
teardown() { teardown_repo; }

@test "contains: HEAD is in its own history" {
    run "$BIRGIT_/contains" HEAD
    [ "$status" -eq 0 ]
}

@test "contains: parent commit is in HEAD history" {
    parent="$(git rev-parse HEAD~1)"
    run "$BIRGIT_/contains" "$parent"
    [ "$status" -eq 0 ]
}

@test "contains: outputs the resolved sha" {
    sha="$(git rev-parse HEAD~1)"
    run "$BIRGIT_/contains" HEAD~1
    [ "$status" -eq 0 ]
    [ "$output" = "$sha" ]
}

@test "contains: exits non-zero when commit is not in history" {
    # Create an orphan branch with its own commit
    git checkout --orphan orphan
    git commit --allow-empty -m "orphan commit"
    orphan_sha="$(git rev-parse HEAD)"
    git checkout master
    run "$BIRGIT_/contains" "$orphan_sha"
    [ "$status" -ne 0 ]
}

@test "contains: two-arg form checks if first is in second's history" {
    first="$(git rev-parse HEAD~2)"
    run "$BIRGIT_/contains" "$first" HEAD
    [ "$status" -eq 0 ]
}
