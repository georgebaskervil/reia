#!/bin/sh
#
# Test and benchmark runner for Reia
# Build: use 'rebar3 compile' and 'rebar3 escript'
# Tests/benchmarks use custom Reia test runner
#

set -e

case "${1:-test}" in
  test)
    rebar3 compile
    ./_build/default/bin/reia test/runner.re
    ;;
  benchmark)
    rebar3 compile
    ./_build/default/bin/reia benchmarks/runner.re
    ;;
  *)
    echo "Usage: $0 [test|benchmark]"
    echo ""
    echo "For building, use rebar3 directly:"
    echo "  rebar3 compile   - Build"
    echo "  rebar3 escript   - Create executable"
    echo "  rebar3 clean     - Clean artifacts"
    exit 1
    ;;
esac
