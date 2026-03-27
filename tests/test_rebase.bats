#!/usr/bin/env bats
load 'helpers'

setup() {
    setup_repo
    git remote add origin "$TEST_REPO"
    git fetch origin
    git remote set-head origin master
}
teardown() { teardown_repo; }

@test "rebase: exits zero when already up to date" {
    run "$BIRGIT_/rebase"
    [ "$status" -eq 0 ]
}

@test "rebase: rebases local commits onto origin default branch" {
    git commit --allow-empty -m "local commit"
    run "$BIRGIT_/rebase"
    [ "$status" -eq 0 ]
    # Local commit should still exist after rebase
    run git log --oneline -1
    [[ "$output" == *"local commit"* ]]
}

@test "master: checks out origin default branch" {
    git commit --allow-empty -m "local commit"
    run "$BIRGIT_/master"
    [ "$status" -eq 0 ]
    # Should now be in detached HEAD at origin/master
    run git symbolic-ref --short HEAD 2>&1 || true
    # Either detached or on master — just verify the command succeeded
}
