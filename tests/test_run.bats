#!/usr/bin/env bats
load 'helpers'

setup()    { setup_repo; }
teardown() { teardown_repo; }

@test "run: executes command in worktree and exits zero" {
    run "$BIRGIT_/run" true
    [ "$status" -eq 0 ]
}

@test "run: command runs in a different directory than cwd" {
    cwd="$(pwd)"
    run "$BIRGIT_/run" pwd
    [ "$status" -eq 0 ]
    [ "$output" != "$cwd" ]
}

@test "run: worktree directory is cleaned up after success" {
    before=$(git worktree list | wc -l)
    "$BIRGIT_/run" true
    after=$(git worktree list | wc -l)
    [ "$before" -eq "$after" ]
}

@test "run: worktree directory is cleaned up after command failure" {
    before=$(git worktree list | wc -l)
    run "$BIRGIT_/run" false
    [ "$status" -ne 0 ]
    after=$(git worktree list | wc -l)
    [ "$before" -eq "$after" ]
}

@test "run: exits with the command exit code" {
    run "$BIRGIT_/run" bash -c "exit 42"
    [ "$status" -eq 42 ]
}

@test "run: arguments with spaces are passed correctly" {
    run "$BIRGIT_/run" bash -c "test 'hello world' = 'hello world'"
    [ "$status" -eq 0 ]
}
