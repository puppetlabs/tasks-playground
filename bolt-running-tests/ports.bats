#!/usr/bin/env bats

@test "Test that nothing is listening on port 80" {
    run lsof -i :80
    [ "$status" -eq 1 ]
}

@test "Test that something is listening on port 22" {
    run lsof -i :22
    [ "$status" -eq 0 ]
}
