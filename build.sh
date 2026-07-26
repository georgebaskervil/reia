#!/bin/sh
#
# Reia build script - replaces the Rakefile
# Usage: ./build.sh [target]
# Targets: all, build, test, clean, scanner, parser, benchmark
#

set -e

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Check Erlang version
check_erl_version() {
  echo "${BLUE}Checking Erlang version...${NC}"
  VERSION=$(erl -version 2>&1 | sed -n 's/.*version \([0-9.]*\).*/\1/p')
  if [ -z "$VERSION" ]; then
    echo "Error retrieving Erlang version. Do you have it installed?"
    exit 1
  fi
  
  REQUIRED="5.7.0"
  if [ "$(printf '%s\n' "$REQUIRED" "$VERSION" | sort -V | head -n1)" = "$REQUIRED" ]; then
    echo "Erlang version $VERSION (ok)"
  else
    echo "Error: Erlang version $VERSION is too old (required: $REQUIRED)"
    exit 1
  fi
}

# Generate scanner from lexer file
generate_scanner() {
  echo "${BLUE}Generating scanner from reia_scan.xrl...${NC}"
  erl -noshell -eval 'leex:file("src/compiler/reia_scan.xrl")' -s erlang halt
}

# Generate parser from grammar file
generate_parser() {
  echo "${BLUE}Generating parser from reia_parse.yrl...${NC}"
  erl -noshell -eval 'yecc:file("src/compiler/reia_parse.yrl", [verbose])' -s erlang halt
}

# Generate JSON parser
generate_json_parser() {
  echo "${BLUE}Generating JSON parser from reia_json_grammar.yrl...${NC}"
  erl -noshell -eval 'yecc:file("src/json/reia_json_grammar.yrl")' -s erlang halt
}

# Compile Erlang source files
compile_erlang() {
  echo "${BLUE}Compiling Erlang source files...${NC}"
  mkdir -p ebin benchmarks/ebin
  
  # Ensure scanner and parser are generated
  if [ ! -f "src/compiler/reia_scan.erl" ]; then
    generate_scanner
  fi
  if [ ! -f "src/compiler/reia_parse.erl" ]; then
    generate_parser
  fi
  if [ ! -f "src/json/reia_json_grammar.erl" ]; then
    generate_json_parser
  fi
  
  # Compile all Erlang files
  for f in src/compiler/*.erl src/core/*.erl src/json/*.erl src/builtins/*.erl; do
    if [ -f "$f" ]; then
      BASENAME=$(basename "$f")
      # Skip quiet files (large generated parsers)
      if [ "$BASENAME" = "reia_parse.erl" ] || [ "$BASENAME" = "reia_scan.erl" ]; then
        erlc -o ebin "$f"
      else
        erlc +debug_info -o ebin "$f"
      fi
    fi
  done
}

# Compile Reia source files
compile_reia() {
  echo "${BLUE}Compiling Reia source files...${NC}"
  mkdir -p ebin lib
  
  # Compile builtins and core to ebin
  for f in src/builtins/*.re src/core/*.re; do
    if [ -f "$f" ]; then
      BASENAME=$(basename "$f" .re)
      OUTPUT="ebin/${BASENAME}.reb"
      echo "  Compiling $f -> $OUTPUT"
      bin/reiac -o "$OUTPUT" "$f" || true
    fi
  done
  
  # Compile lib to lib
  for f in lib/*.re; do
    if [ -f "$f" ]; then
      BASENAME=$(basename "$f" .re)
      OUTPUT="lib/${BASENAME}.reb"
      echo "  Compiling $f -> $OUTPUT"
      bin/reiac -o "$OUTPUT" "$f" || true
    fi
  done
}

# Compile benchmark files
compile_benchmarks() {
  echo "${BLUE}Compiling benchmark files...${NC}"
  mkdir -p benchmarks/ebin
  
  for f in benchmarks/*.erl; do
    if [ -f "$f" ]; then
      erlc +debug_info -o benchmarks/ebin "$f"
    fi
  done
}

# Build everything
build() {
  echo "${GREEN}Building Reia...${NC}"
  check_erl_version
  generate_scanner
  generate_parser
  generate_json_parser
  compile_erlang
  compile_reia
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
  compile_benchmarks
  bin/reia benchmarks/runner.re
}

# Clean build artifacts
clean() {
  echo "${BLUE}Cleaning...${NC}"
  rm -f src/compiler/reia_scan.erl src/compiler/reia_parse.erl
  rm -f src/json/reia_json_grammar.erl
  rm -rf ebin/*.beam ebin/*.reb
  rm -rf lib/*.reb
  rm -rf benchmarks/ebin/*.beam
  rm -f erl_crash.dump
  echo "${GREEN}Clean complete!${NC}"
}

# Main logic
TARGET="${1:-all}"

case "$TARGET" in
  all|build)
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
  scanner)
    check_erl_version
    generate_scanner
    compile_erlang
    ;;
  parser)
    check_erl_version
    generate_parser
    compile_erlang
    ;;
  *)
    echo "Usage: $0 [target]"
    echo "Targets:"
    echo "  all       - Build everything (default)"
    echo "  build     - Same as all"
    echo "  test      - Build and run tests"
    echo "  benchmark - Build and run benchmarks"
    echo "  scanner   - Generate and compile scanner only"
    echo "  parser    - Generate and compile parser only"
    echo "  clean     - Remove build artifacts"
    exit 1
    ;;
esac
