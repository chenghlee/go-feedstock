#!/usr/bin/env bash
set -euf

# Test we are running GO under $CONDA_PREFIX
test "$(which go)" == "${CONDA_PREFIX}/bin/go"


# Print diagnostics
go env


# Run go's built-in test
case $(uname -s) in
  Darwin)
    # Expect PASS when run independently
    go tool dist test -v -no-rebuild -run='!^runtime|runtime:cpu124|net$'
    go tool dist test -v -no-rebuild -run='^runtime$'
    go tool dist test -v -no-rebuild -run='^runtime:cpu124$'
    go tool dist test -v -no-rebuild -run='^net$'
    # Expect FAIL
    ;;
  Linux)
    # Expect PASS
    go tool dist test -v -no-rebuild
    ;;
esac
