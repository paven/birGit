#!/usr/bin/env bats
load 'helpers'

setup() {
    setup_repo
    for i in 1 2 3 4 5 6 7 8 9 10 11 12; do
        git commit --allow-empty -m "commit $i"
    done
}
teardown() { teardown_repo; }

@test "log: exits zero" {
    run "$BIRGIT_/log"
    [ "$status" -eq 0 ]
}

@test "log: defaults to 10 commits" {
    run "$BIRGIT_/log"
    [ "$status" -eq 0 ]
    # 12 commits exist, default is 10; count non-empty lines
    line_count=$(echo "$output" | grep -c '.' || true)
    [ "$line_count" -le 10 ]
}

@test "log: -n3 limits output to 3 commits" {
    run "$BIRGIT_/log" -n3
    [ "$status" -eq 0 ]
    commit_count=$(echo "$output" | grep -cE '^\*' || true)
    [ "$commit_count" -eq 3 ]
}

@test "log: output contains commit subject" {
    run "$BIRGIT_/log" -n1
    [ "$status" -eq 0 ]
    [[ "$output" == *"commit 12"* ]]
}

@test "log: --help exits zero" {
    run "$BIRGIT_/log" --help
    [ "$status" -eq 0 ]
}
