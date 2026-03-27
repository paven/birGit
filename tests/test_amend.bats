#!/usr/bin/env bats
load 'helpers'

setup() {
    setup_repo
    # Add a second commit so origin/master has a commit with a parent
    echo "base" > base.txt
    git add base.txt && git commit -m "base commit"
    git remote add origin "$TEST_REPO"
    git fetch origin
    git branch --set-upstream-to=origin/master master
    # Unpushed commit to amend
    echo "v1" > file.txt
    git add file.txt
    git commit -m "add file"
}
teardown() { teardown_repo; }

@test "amend: exits non-zero when target is on shared origin/master" {
    # HEAD~1 is "base commit" which is on origin/master and has a parent
    run "$BIRGIT_/amend" HEAD~1
    [ "$status" -ne 0 ]
    [[ "$output" == *"shared history"* ]]
}

@test "amend: exits non-zero when fixup! already exists in range" {
    git commit --allow-empty -m "fixup! add file"
    run "$BIRGIT_/amend" HEAD~1
    [ "$status" -ne 0 ]
    [[ "$output" == *"fixup!"* ]]
}

@test "amend: exits non-zero when squash! already exists in range" {
    git commit --allow-empty -m "squash! add file"
    run "$BIRGIT_/amend" HEAD~1
    [ "$status" -ne 0 ]
    [[ "$output" == *"squash!"* ]]
}
