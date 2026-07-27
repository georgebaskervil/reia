# Reia: Maintenance Mode Notice

## ⚠️ Project Status

Reia is maintained as a **historical archive and research project** with ongoing maintenance for compatibility with modern Erlang versions.

### What This Means

- ✅ **Bug fixes**: We fix issues that prevent the language from running
- ✅ **Compatibility**: We maintain support for current Erlang/OTP versions  
- ✅ **Documentation**: We improve guides and examples
- ❌ **New features**: The language is considered feature-complete
- ❌ **Language changes**: We do not add new syntax or semantics

### Recommended Alternative

**For new projects**, use **[Elixir](https://github.com/elixir-lang/elixir)**, which:

- Builds on Erlang's concepts (like Reia does)
- Has an active development community
- Provides modern tooling and libraries
- Enjoys widespread production use

Elixir was created *after* Reia and represents the natural evolution of Ruby-like languages for the Erlang VM.

### Why Maintain Reia?

1. **Historical value**: Documents an interesting approach to Erlang interoperability
2. **Research interest**: Demonstrates pattern matching and functional concepts
3. **Educational**: Shows language design trade-offs
4. **Archival**: Preserves 2008-2010 work by Tony Arcieri and contributors

### Erlang/OTP Support

| Erlang | Status | CI/CD |
|--------|--------|-------|
| 27, 28, 29+ | ✅ Supported | Tested |
| 22-26 | ⚠️ Untested | - |
| 21 and earlier | ❌ Not supported | - |

### 2026 Updates

The 2026 maintenance refresh focused on:
- ✅ Erlang 29 compatibility
- ✅ Removing Ruby/Rake dependency
- ✅ Setting up modern CI/CD
- ✅ Improving documentation

No new language features were added.

### Getting Started

If you want to explore Reia as a historical project:

```bash
# Clone and build
git clone https://github.com/georgebaskervil/reia.git
cd reia
./build.sh build

# Run tests
./build.sh test

# See docs/INSTALL.md for detailed setup
```

### Contributing

Contributions welcome for:
- Bug fixes and maintenance
- Documentation improvements
- Test additions
- Build system improvements

See **[CONTRIBUTING.md](../CONTRIBUTING.md)** for guidelines.

---

**Thank you for your interest in Reia!** 🎉
