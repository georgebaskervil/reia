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
- **Standard POSIX shell** (bash, sh) - for build.sh wrapper
- No other dependencies (Ruby/Rake no longer required!)

Get Erlang from: https://www.erlang.org/
Get rebar3 from: https://rebar3.org/

### Quick Start

```bash
# Build the project (uses rebar3)
./build.sh build

# Run tests (101 assertions)
./build.sh test

# Run benchmarks
./build.sh benchmark

# Clean build artifacts
./build.sh clean
```

### Build Targets

- `./build.sh build` - Compile all source via rebar3 (default)
- `./build.sh test` - Build and run the test suite
- `./build.sh benchmark` - Build and run benchmarks
- `./build.sh clean` - Remove all build artifacts

Alternatively, use rebar3 directly:
```bash
rebar3 compile    # Compile Erlang, Leex, Yecc, and Reia source
rebar3 clean      # Clean build artifacts
```

### What's Changed in 2026

Recent updates for modern Erlang compatibility:
- ✅ Migrated to rebar3 for unified build system
- ✅ Removed complex Rakefile
- ✅ Fixed Erlang 29 compatibility issues (parser, bytecode, stacktrace)
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

