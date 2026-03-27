#!/usr/bin/env bats
load 'helpers'

setup() {
    setup_repo
    git remote add origin "$TEST_REPO"
    git fetch origin
    git remote set-head origin master
    git branch --set-upstream-to=origin/master master

    # Create a feature branch with a commit
    git checkout -b feature-x
    echo "feature" > feature.txt
    git add feature.txt
    git commit -m "feature work"
}
teardown() { teardown_repo; }

@test "bubble: merges feature branch into master with -m message" {
    run "$BIRGIT_/bubble" -m "merge feature-x"
    [ "$status" -eq 0 ]
    run git log --oneline master
    [[ "$output" == *"merge feature-x"* ]]
}

@test "bubble: leaves working tree on master after merge" {
    "$BIRGIT_/bubble" -m "merge feature-x"
    run "$BIRGIT_/branch"
    [ "$output" = "master" ]
}

@test "bubble: exits non-zero for unknown option" {
    run "$BIRGIT_/bubble" --unknown
    [ "$status" -ne 0 ]
}
