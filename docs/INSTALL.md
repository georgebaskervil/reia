# Installation Guide

## Requirements

- **Operating System**: Linux, macOS, BSD, or Windows (with WSL2)
- **Erlang**: Version 27, 28, or 29+ (minimum R13B / 5.7.0)
- **Shell**: bash, sh, or other POSIX-compatible shell
- **Git**: For cloning the repository (optional if using zip download)

**No additional dependencies required** - Ruby, Rake, and other build tools are not needed!

## Step 1: Install Erlang

### macOS (Homebrew)

```bash
brew install erlang
```

Verify:
```bash
erl -version
# Erlang 29.0.3 (erts-14.2.1) ...
```

### Ubuntu/Debian

```bash
apt-get update
apt-get install erlang
```

### CentOS/RHEL

```bash
yum install erlang
```

### macOS (MacPorts)

```bash
sudo port install erlang
```

### Windows (WSL2 Recommended)

1. Install WSL2: https://docs.microsoft.com/en-us/windows/wsl/install
2. Install Ubuntu: `wsl --install -d Ubuntu`
3. Inside Ubuntu, follow the Ubuntu/Debian instructions above

### Building from Source

Visit https://www.erlang.org/downloads and follow build instructions for your platform.

Recommended for development:
```bash
# Download source
wget https://github.com/erlang/otp/releases/download/OTP-29.0.3/otp_src_29.0.3.tar.gz
tar xzf otp_src_29.0.3.tar.gz
cd otp_src_29.0.3

# Configure and build (takes ~10-15 minutes)
./configure
make
sudo make install
```

## Step 2: Get Reia

### Option A: Clone from GitHub (Recommended)

```bash
git clone https://github.com/georgebaskervil/reia.git
cd reia
```

### Option B: Download as ZIP

1. Go to https://github.com/georgebaskervil/reia
2. Click "Code" → "Download ZIP"
3. Extract the archive

## Step 3: Install rebar3

rebar3 is the Erlang build tool that Reia uses.

```bash
# Download rebar3 binary (or see https://rebar3.org/ for alternatives)
mkdir -p ~/.local/bin
wget https://s3.amazonaws.com/rebar3/rebar3 -O ~/.local/bin/rebar3
chmod +x ~/.local/bin/rebar3

# Add to PATH (add this to your ~/.bashrc or ~/.zshrc)
export PATH="~/.local/bin:$PATH"

# Verify
rebar3 version
```

Or use your package manager:
```bash
brew install rebar3      # macOS
apt-get install rebar3   # Ubuntu/Debian
```

## Step 4: Build Reia

```bash
cd reia
rebar3 compile
```

**Expected output:**
```
===> Verifying dependencies...
===> Analyzing applications...
===> Compiling reia
Compiling Reia source files...
===> Building escript reia...
```

## Step 5: Build the Reia Executable

```bash
rebar3 escript
```

This creates `_build/default/bin/reia` - the standalone Reia executable.

## Step 6: Verify Installation

```bash
# Run test suite (should see "101 assertions, 0 failures, 0 errors")
./_build/default/bin/reia test/runner.re

# Run interactive REPL
./_build/default/bin/reia --ire

# Or use the convenience wrapper
./_build/default/bin/reia test/runner.re
```

### Optional: Install reia executable to PATH

```bash
cp _build/default/bin/reia ~/.local/bin/reia
chmod +x ~/.local/bin/reia

# Now you can run from anywhere:
reia script.re
reia --ire
```

## Troubleshooting

### "erl: command not found"

**Problem**: Erlang is not installed or not in PATH

**Solution**:
```bash
# Verify Erlang is installed
which erl

# If not found, reinstall Erlang or add to PATH
export PATH="/opt/erlang/bin:$PATH"  # or your Erlang installation path
```

### "rebar3: command not found"

**Problem**: rebar3 is not installed or not in PATH

**Solution**:
```bash
# Verify rebar3 is installed
which rebar3

# If not found, install it (see Step 3 above)
# Or add to PATH if installed elsewhere
export PATH="/path/to/rebar3:$PATH"
```

### "Erlang version is too old"

**Problem**: You have Erlang < R13B (5.7.0)

**Solution**:
```bash
# Show current version
erl -version

# Upgrade Erlang (see Step 1 above)
brew upgrade erlang  # macOS
apt-get upgrade erlang  # Ubuntu/Debian
```

### Build fails with errors

**Problem**: Incomplete build or cached artifacts

**Solution**:
```bash
# Clean and rebuild
rebar3 clean
rebar3 compile

# Or use the convenience wrapper
rebar3 clean
rebar3 compile
```

### Tests show "0 tests" or other issues

**Problem**: Reia modules not compiled

**Solution**:
```bash
# Rebuild from scratch
rebar3 clean
rebar3 compile

# Verify compiled files
ls -la _build/default/lib/reia/ebin/*.reb

# Run tests
./_build/default/bin/reia test/runner.re
erl -version
```

### JSON parsing or compilation fails

**Problem**: Source files not compiled properly

**Solution**:
```bash
# Rebuild from scratch
rebar3 clean
rebar3 compile
rebar3 escript

# Run tests to verify
./_build/default/bin/reia test/runner.re
```

## Platform-Specific Notes

### macOS ARM64 (Apple Silicon)

Works with native Erlang builds:
```bash
# Homebrew automatically installs correct version
brew install erlang

# Verify correct architecture
erl -eval 'erlang:system_info(system_architecture).'
```

### WSL2 on Windows

Build works normally in WSL2 Ubuntu environment. For best performance:

```bash
# Increase available memory/CPU for WSL2
# Add to .wslconfig:
# [wsl2]
# memory=4GB
# processors=4
```

### Virtual Machines / Docker

Reia builds successfully in containerized environments:

```dockerfile
FROM ubuntu:22.04
RUN apt-get update && apt-get install -y erlang git
RUN mkdir -p ~/.local/bin && wget https://s3.amazonaws.com/rebar3/rebar3 -O ~/.local/bin/rebar3 && chmod +x ~/.local/bin/rebar3
ENV PATH="~/.local/bin:$PATH"
WORKDIR /app
COPY . .
RUN rebar3 compile
RUN rebar3 escript
CMD ["./_build/default/bin/reia", "test/runner.re"]
```

## Next Steps

### Run Your First Reia Program

Create `hello.re`:
```reia
"Hello, World!".puts()
```

Run it:
```bash
./_build/default/bin/reia hello.re

# Or if installed to PATH:
reia hello.re
```

### Explore Examples

Check out example programs:
```bash
ls examples/
./_build/default/bin/reia examples/hello.re
```

### Run Benchmarks

```bash
rebar3 compile && ./_build/default/bin/reia benchmarks/runner.re

# Or use convenience wrapper:
./_build/default/bin/reia benchmarks/runner.re
```

Expected output:
```
Running benchmark tests 10 times each
recursion Reia:0.041685s Erlang:0.025510s that's 1.634080x slower
sleep Reia:10.010873s Erlang:10.010051s that's 1.000082x slower
...
```

### Read Documentation

- **[README.md](../README.md)** - Project overview
- **[CONTRIBUTING.md](../CONTRIBUTING.md)** - How to contribute
- **[CHANGELOG.md](../CHANGELOG.md)** - Version history

## Getting Help

- **GitHub Issues**: Report bugs at https://github.com/georgebaskervil/reia/issues
- **Pull Requests**: Contribute fixes at https://github.com/georgebaskervil/reia/pulls
- **Documentation**: Check docs/ directory for more information

## Advanced Topics

### Building with Specific Erlang Version

```bash
# If multiple Erlang versions installed
# Use environment variables or path selection

# Example: Using specific Erlang
/opt/erlang-29/bin/erl -version
export PATH="/opt/erlang-29/bin:$PATH"
rebar3 compile
```

### Customizing Build

```bash
# Clean build only
rebar3 clean

# Quick development rebuild
rebar3 compile

# Rebuild after changes
rebar3 compile
```

### Development Environment Setup

```bash
# Clone and set up for development
git clone https://github.com/georgebaskervil/reia.git
cd reia
git config core.filemode true

# First build
rebar3 compile

# Create standalone executable
rebar3 escript

# Watch for changes (not built-in, but you can use inotify-tools)
# Or just run rebar3 compile when you make changes
```

## Uninstall

```bash
# Remove cloned repository
rm -rf reia/

# Erlang remains installed (use your package manager to remove if needed)
# macOS: brew uninstall erlang
# Ubuntu: apt-get remove erlang
```

---

**If you encounter issues not covered here, please open an issue on GitHub:**
https://github.com/georgebaskervil/reia/issues
