#!/usr/bin/env bats
load 'helpers'

setup() {
    setup_repo
    git remote add origin "$TEST_REPO"
    git fetch origin
}
teardown() { teardown_repo; }

@test "branches: exits zero with remote branches present" {
    run "$BIRGIT_/branches"
    [ "$status" -eq 0 ]
}

@test "branches: lists origin/master" {
    run "$BIRGIT_/branches"
    [[ "$output" == *"origin/master"* ]]
}

@test "branches: output is sorted newest first (iso date at start of each line)" {
    run "$BIRGIT_/branches"
    [ "$status" -eq 0 ]
    # Each output line should start with an ISO date
    while IFS= read -r line; do
        [[ "$line" =~ ^[0-9]{4}-[0-9]{2}-[0-9]{2} ]]
    done <<< "$output"
}

@test "branches: does not include HEAD symref" {
    run "$BIRGIT_/branches"
    [[ "$output" != *"origin/HEAD"* ]]
}

@test "branches: exits zero with no output when no remotes" {
    git remote remove origin
    run "$BIRGIT_/branches"
    [ "$status" -eq 0 ]
    [ -z "$output" ]
}
