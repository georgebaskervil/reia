#!/bin/sh
#
# Reia build script - wrapper around rebar3
# For convenience; rebar3 commands can be used directly
#

set -e

# Forward all arguments to rebar3, with some convenience targets
TARGET="${1:-compile}"

case "$TARGET" in
  build|compile)
    rebar3 compile
    ;;
  test)
    rebar3 compile && _build/default/bin/reia test/runner.re
    ;;
  benchmark)
    rebar3 compile && erlc +debug_info -o benchmarks/ebin benchmarks/*.erl 2>/dev/null || true && _build/default/bin/reia benchmarks/runner.re
    ;;
  clean)
    rebar3 clean && rm -f erl_crash.dump
    ;;
  escript)
    rebar3 escript
    ;;
  *)
    exec rebar3 "$@"
    ;;
esac
