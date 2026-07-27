#!/bin/sh
#
# Reia build script - wrapper around rebar3
# Usage: ./build.sh [target]
# Targets: build, test, clean, benchmark
#

set -e

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Check if rebar3 is available
check_rebar3() {
  if ! command -v rebar3 &> /dev/null; then
    echo "Error: rebar3 not found in PATH"
    echo "Install rebar3 from: https://rebar3.org/"
    exit 1
  fi
}

# Build with rebar3
build() {
  echo "${GREEN}Building Reia (via rebar3)...${NC}"
  check_rebar3
  rebar3 compile
  echo "${GREEN}Build complete!${NC}"
}

# Run tests
run_tests() {
  echo "${GREEN}Running tests...${NC}"
  build
  bin/reia test/runner.re
}

# Run benchmarks
run_benchmarks() {
  echo "${GREEN}Running benchmarks...${NC}"
  build
  mkdir -p benchmarks/ebin
  erlc +debug_info -o benchmarks/ebin benchmarks/*.erl 2>/dev/null || true
  bin/reia benchmarks/runner.re
}

# Clean with rebar3
clean() {
  echo "${BLUE}Cleaning (via rebar3)...${NC}"
  check_rebar3
  rebar3 clean
  rm -f erl_crash.dump
  echo "${GREEN}Clean complete!${NC}"
}

# Main logic
TARGET="${1:-build}"

case "$TARGET" in
  build)
    build
    ;;
  test)
    run_tests
    ;;
  benchmark)
    run_benchmarks
    ;;
  clean)
    clean
    ;;
  *)
    echo "Usage: $0 [target]"
    echo "Targets:"
    echo "  build     - Compile all source (default)"
    echo "  test      - Build and run tests"
    echo "  benchmark - Build and run benchmarks"
    echo "  clean     - Remove build artifacts"
    exit 1
    ;;
esac
