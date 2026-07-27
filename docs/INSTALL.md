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

## Step 3: Build Reia

```bash
cd reia
./build.sh build
```

**Expected output:**
```
Building Reia...
Checking Erlang version...
Erlang version 29.0.3 (ok)
Generating scanner from reia_scan.xrl...
Generating parser from reia_parse.yrl...
Generating JSON parser from reia_json_grammar.yrl...
Compiling Erlang source files...
Compiling Reia source files...
Build complete!
```

## Step 4: Verify Installation

```bash
# Run test suite (should see "101 assertions, 0 failures, 0 errors")
./build.sh test

# Run benchmarks (optional)
./build.sh benchmark
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

### "build.sh: permission denied"

**Problem**: Build script is not executable

**Solution**:
```bash
chmod +x build.sh
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

### Build fails with "undefined" errors

**Problem**: Incomplete build or cached artifacts

**Solution**:
```bash
# Clean and rebuild
./build.sh clean
./build.sh build

# Or completely remove build artifacts
rm -rf ebin/ lib/*.reb src/compiler/reia_scan.erl src/compiler/reia_parse.erl
./build.sh build
```

### Tests show "0 tests" or other issues

**Problem**: Reia modules not compiled

**Solution**:
```bash
# Verify your build worked
ls -la ebin/*.reb | head -5

# If empty, rebuild
./build.sh clean
./build.sh build

# Check for Erlang version issues
erl -version
```

### "No such file or directory: bin/reiac"

**Problem**: Reia compiler not available

**Solution**:
```bash
# Verify build completed
ls -la bin/reiac

# If missing, rebuild with verbose output
./build.sh build 2>&1 | tail -20
```

### JSON parsing fails

**Problem**: JSON modules not compiled

**Solution**:
```bash
# Rebuild from scratch
./build.sh clean
./build.sh build
./build.sh test
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
WORKDIR /app
COPY . .
RUN ./build.sh build
CMD ["./build.sh", "test"]
```

## Next Steps

### Run Your First Reia Program

Create `hello.re`:
```reia
"Hello, World!".puts()
```

Run it:
```bash
bin/reia hello.re
```

### Explore Examples

Check out example programs:
```bash
ls examples/
```

### Run Benchmarks

```bash
./build.sh benchmark
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
./build.sh build
```

### Customizing Build

```bash
# Clean build only
./build.sh clean

# Build specific targets
./build.sh parser    # Parse tables only
./build.sh scanner   # Lexer only

# Quick development rebuild
./build.sh build
```

### Development Environment Setup

```bash
# Clone and set up for development
git clone https://github.com/georgebaskervil/reia.git
cd reia
git config core.filemode true

# Make scripts executable
chmod +x build.sh bin/reia bin/ire bin/reiac

# First build
./build.sh build

# Watch for changes (not built-in, but you can use inotify-tools)
# Or just run ./build.sh build when you make changes
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
