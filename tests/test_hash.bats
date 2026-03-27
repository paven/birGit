#!/usr/bin/env bats
load 'helpers'

setup()    { setup_repo; }
teardown() { teardown_repo; }

@test "hash: resolves HEAD to a 40-char sha" {
    run "$BIRGIT_/hash" HEAD
    [ "$status" -eq 0 ]
    [[ "$output" =~ ^[0-9a-f]{40}$ ]]
}

@test "hash: resolves a branch name to a sha" {
    run "$BIRGIT_/hash" master
    [ "$status" -eq 0 ]
    [[ "$output" =~ ^[0-9a-f]{40}$ ]]
}

@test "hash: exits non-zero for unknown ref" {
    run "$BIRGIT_/hash" no-such-ref
    [ "$status" -ne 0 ]
}

@test "hash: HEAD and master resolve to the same sha on a fresh repo" {
    head_sha="$("$BIRGIT_/hash" HEAD)"
    master_sha="$("$BIRGIT_/hash" master)"
    [ "$head_sha" = "$master_sha" ]
}
