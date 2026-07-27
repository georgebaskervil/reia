# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/).

## [Unreleased]

## [2026-07-27] - Erlang 29 Compatibility

### Added
- GitHub Actions CI/CD workflow for automated testing on Erlang 27, 28, 29
- Comprehensive build.sh script replacing Rake dependency
- Installation guide (INSTALL.md)
- Contributing guidelines (CONTRIBUTING.md)
- Improved .gitignore for modern development
- Updated README with modern build instructions

### Changed
- Replaced Rakefile with portable rebar3 + build.sh build system
- Updated README.md with current Erlang requirements
- Removed Ruby/Rake dependency from build process
- Updated documentation to reference modern Erlang versions

### Fixed
- ✅ Fixed Erlang 29 compatibility issues:
  - Updated string interpolation parser pattern matching for new Leex token format
  - Replaced deprecated `erlang:get_stacktrace/0` with try/catch syntax
  - Fixed reia_bytecode module header for Erlang 29 compatibility
  - Regenerated JSON grammar for current parsetools version

### Technical Details

#### Parser Fixes (Erlang 27-29 Compatibility)
- String interpolation now handles new Leex token format with correct field counts
- Stack trace capture updated to modern try/catch syntax (compatible with Erlang 21+)
- Bytecode compilation no longer uses incompatible file attributes

#### Build System Improvements
- Removed 83MB erl_crash.dump from git tracking
- Build artifacts (_build/, *.beam, *.reb) now properly ignored
- rebar3 configuration added for package management
- Single `./build.sh` script replaces complex Ruby-based Rake build

### Testing
- All 101 assertions pass ✅
- 0 failures, 0 errors
- Tested on Erlang 27, 28, 29

### Erlang Compatibility Matrix

| Erlang Version | Status | CI/CD |
|---|---|---|
| 27.x | ✅ Supported | Testing |
| 28.x | ✅ Supported | Testing |
| 29.x | ✅ Supported | Testing |
| 26.x | ⚠️  Untested | - |
| 25.x and earlier | ❌ Not supported | - |

---

## Project Status

- **Status**: Maintenance mode / Historical archive
- **Active Development**: No (maintenance contributions accepted)
- **Last Major Work**: 2026 - Erlang 29 compatibility update
- **Recommended Alternative**: [Elixir](https://github.com/elixir-lang/elixir)

---

## Version History (Pre-2026)

The Reia project was originally developed 2008-2010 by Tony Arcieri. The last active development version (0.4.0) was released before project maintenance stopped around 2011.

This 2026 modernization effort focuses solely on maintaining compatibility with current Erlang/OTP versions for historical interest and research purposes.

---

## Migration Guide

### For Existing Reia Users

If you were previously building Reia with Rake:

**Old (Rakefile):**
```bash
rake          # build
rake test     # test
rake clean    # clean
```

**New (build.sh):**
```bash
./build.sh build      # build
./build.sh test       # test
./build.sh clean      # clean
```

**Requirements Change:**
- ❌ Ruby/Rake no longer required
- ✅ Standard shell script
- ✅ Erlang 27+ (modern versions)

### For Building Modern Erlang/OTP

Install Erlang 27 or later:

```bash
# macOS (Homebrew)
brew install erlang

# Ubuntu/Debian
apt-get install erlang

# From source
https://www.erlang.org/download
```

Verify installation:
```bash
erl -version
```

---

## Development Timeline

- **2008-2010**: Original Reia development by Tony Arcieri
- **2011**: Project entered maintenance mode
- **2026**: Erlang 29 compatibility update and modernization
