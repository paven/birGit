#!/usr/bin/env bats
load 'helpers'

setup() {
    setup_repo
    # Simulate origin/master by adding the repo as its own remote
    git remote add origin "$TEST_REPO"
    git fetch origin
    git branch --set-upstream-to=origin/master master
}
teardown() { teardown_repo; }

@test "shared: HEAD is on origin/master in a fresh repo" {
    run "$BIRGIT_/shared" HEAD
    [ "$status" -eq 0 ]
    [[ "$output" == *"origin/master"* ]]
}

@test "shared: a new local-only commit is not shared" {
    git commit --allow-empty -m "local only"
    run "$BIRGIT_/shared" HEAD
    [ "$status" -ne 0 ]
}

@test "shared: defaults to HEAD when no arg given" {
    run "$BIRGIT_/shared"
    [ "$status" -eq 0 ]
}

@test "shared: exits non-zero for unknown ref" {
    run "$BIRGIT_/shared" no-such-ref
    [ "$status" -ne 0 ]
}
