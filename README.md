Reia
====

> **Note**: Reia was a pioneering Ruby-like language for the Erlang VM, designed as a proof-of-concept for bringing Ruby's elegance to the BEAM platform. The project is no longer under active development. If you're interested in similar ideas, check out **[Elixir](https://github.com/elixir-lang/elixir)**, which brought many of Reia's inspirations to production maturity.

This repository maintains Reia as a historical artifact and for research purposes, with ongoing maintenance for modern Erlang versions.

**📋 See [docs/DEPRECATION_NOTICE.md](docs/DEPRECATION_NOTICE.md) for full project status.**

About Reia
----------

Reia (pronounced RAY-uh) is a Ruby-like scripting language for the Erlang virtual machine (BEAM). The language combines Ruby's friendly syntax with Erlang's powerful concurrent and distributed computing capabilities.

Building Reia
-------------

### Requirements

- **Erlang 27, 28, or 29+** (R13B or later; tested with Erlang 29.0.3)
- **rebar3** - Erlang build tool
- No other dependencies (Ruby/Rake no longer required!)

Get Erlang from: https://www.erlang.org/
Get rebar3 from: https://rebar3.org/

### Quick Start

```bash
# Build the project
rebar3 compile

# Build standalone executable
rebar3 escript

# Run the Reia REPL
./_build/default/bin/reia --ire

# Run a Reia script
./_build/default/bin/reia script.re

# Run tests (101 assertions)
./_build/default/bin/reia test/runner.re

# Run benchmarks
./_build/default/bin/reia benchmarks/runner.re
```

### Build Commands

- `rebar3 compile` - Compile all source (Erlang, Leex, Yecc, and Reia)
- `rebar3 escript` - Build standalone reia executable to `_build/default/bin/reia`
- `rebar3 clean` - Remove all build artifacts

### Test and Benchmark Commands

Reia uses custom test/benchmark runners (not eunit). Use the build script as a convenience:

- `./build.sh test` - Run test suite (compiles + executes test/runner.re)
- `./build.sh benchmark` - Run benchmarks (compiles + executes benchmarks/runner.re)

Or run manually:
```bash
rebar3 compile && ./_build/default/bin/reia test/runner.re
rebar3 compile && ./_build/default/bin/reia benchmarks/runner.re
```

### Reia Executable Usage

Once built, the reia executable provides:
```bash
reia script.re           # Run a Reia script
reia --ire               # Start interactive REPL
reia -i                  # Short form for --ire
reia -o output.reb file.re  # Compile file to bytecode
```

### What's Changed in 2026

Recent updates for modern Erlang compatibility:
- ✅ Consolidated all tooling under rebar3 (single build system)
- ✅ Created standalone reia executable (replaces multiple shell scripts)
- ✅ Removed Rakefile, fixed Erlang 29 compatibility
- ✅ All tests passing (101 assertions, 0 failures)
- ✅ No Ruby/Rake dependency required


Implementation
--------------

Here's some implementation details about Reia:

* **Leex-based scanner** - Lexical analysis using Erlang's Leex tool
* **Yecc-based parser** - Syntax analysis using Erlang's Yecc parser generator
* **Multi-pass compiler** - Successive parse transforms convert Reia parse trees into:
  1. Intermediate representation
  2. Erlang abstract format
  3. BEAM/HiPE bytecode

Documentation
--------------

* **[INSTALL.md](docs/INSTALL.md)** - Detailed installation and troubleshooting guide
* **[CONTRIBUTING.md](CONTRIBUTING.md)** - How to contribute to the project
* **[CHANGELOG.md](CHANGELOG.md)** - Version history and compatibility notes

Historical References
---------------------

* **Home Page** (archived): http://reia-lang.org
* **Mailing List** (archived): http://groups.google.com/group/reia
* **Author**: Tony Arcieri (creator)

Project Status
--------------

- **Status**: Historical archive / maintenance mode
- **Active Development**: No (but accepting maintenance PRs)
- **Current Erlang Support**: 27, 28, 29+
- **Test Suite**: 101 assertions, all passing ✅
- **Last Major Update**: 2026 (Erlang 29 compatibility)

For active development of similar concepts, see:
- **[Elixir](https://github.com/elixir-lang/elixir)** - Production-ready language for BEAM
- **[Erlang/OTP](https://github.com/erlang/otp)** - The BEAM virtual machine

