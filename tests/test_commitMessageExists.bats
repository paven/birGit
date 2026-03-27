#!/usr/bin/env bats
load 'helpers'

setup() {
    setup_repo
    git commit --allow-empty -m "fixup! previous work"
    git commit --allow-empty -m "normal commit"
}
teardown() { teardown_repo; }

@test "commitMessageExists: finds fixup! in recent history" {
    # HEAD~1 = "fixup!", HEAD~1^.. includes HEAD~1 and HEAD
    run "$BIRGIT_/commitMessageExists" HEAD~1 "fixup!"
    [ "$status" -eq 0 ]
}

@test "commitMessageExists: exits non-zero when pattern is absent" {
    run "$BIRGIT_/commitMessageExists" HEAD~1 "squash!"
    [ "$status" -ne 0 ]
}

@test "commitMessageExists: does not match commits outside the range" {
    # HEAD^.. is just HEAD ("normal commit") — fixup! should not be found
    run "$BIRGIT_/commitMessageExists" HEAD "fixup!"
    [ "$status" -ne 0 ]
}
