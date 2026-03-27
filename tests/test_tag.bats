#!/usr/bin/env bats
load 'helpers'

setup() {
    setup_repo
    git commit --allow-empty -m "v1"
    git tag v1.0
    git commit --allow-empty -m "v2"
    git tag v2.0
    git commit --allow-empty -m "v3"
    git tag v3.0
}
teardown() { teardown_repo; }

@test "tag: returns latest tag by default" {
    run "$BIRGIT_/tag"
    [ "$status" -eq 0 ]
    [ "$output" = "refs/tags/v3.0" ]
}

@test "tag: -n2 returns the two latest tags" {
    run "$BIRGIT_/tag" -n2
    [ "$status" -eq 0 ]
    [ "$(echo "$output" | wc -l | tr -d ' ')" = "2" ]
    [[ "$output" == *"refs/tags/v3.0"* ]]
    [[ "$output" == *"refs/tags/v2.0"* ]]
}

@test "tag: -b1 offsets by one (returns second-newest)" {
    run "$BIRGIT_/tag" -b1
    [ "$status" -eq 0 ]
    [ "$output" = "refs/tags/v2.0" ]
}

@test "tag: -b1 -n2 returns two tags starting from second-newest" {
    run "$BIRGIT_/tag" -b1 -n2
    [ "$status" -eq 0 ]
    [[ "$output" == *"refs/tags/v1.0"* ]]
    [[ "$output" == *"refs/tags/v2.0"* ]]
}

@test "tag: exits zero with no output when no tags exist" {
    setup_repo
    run "$BIRGIT_/tag"
    [ "$status" -eq 0 ]
    [ -z "$output" ]
}
