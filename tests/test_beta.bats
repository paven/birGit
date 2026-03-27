#!/usr/bin/env bats
load 'helpers'

setup() {
    setup_repo
    git remote add origin "$TEST_REPO"
    git fetch origin
    git remote set-head origin master
}
teardown() { teardown_repo; }

# --- beta dispatcher ---

@test "beta: lists available commands with no argument" {
    run "$BIRGIT_/beta"
    [ "$status" -eq 0 ]
    [[ "$output" == *"prune"* ]]
}

@test "beta: exits non-zero for unknown command" {
    run "$BIRGIT_/beta" no-such-command
    [ "$status" -ne 0 ]
    [[ "$output" == *"not a valid command"* ]]
}

# --- beta prune ---

@test "beta prune: exits zero with no output when no merged branches" {
    run "$BIRGIT_/beta_/prune"
    [ "$status" -eq 0 ]
    [ -z "$output" ]
}

@test "beta prune: lists a branch that is already merged into origin/master" {
    # Create and "merge" a branch by making its commit reachable from origin/master
    git checkout -b merged-feature
    git commit --allow-empty -m "feature work"
    git checkout master
    git merge --no-ff merged-feature -m "Merge merged-feature"
    git fetch origin  # update origin/master ref to include the merge
    run "$BIRGIT_/beta_/prune"
    [ "$status" -eq 0 ]
    [[ "$output" == *"origin/merged-feature"* ]]
}
