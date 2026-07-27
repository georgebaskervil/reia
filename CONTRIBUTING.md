# Contributing to Reia

Thank you for your interest in Reia! This document provides guidelines and instructions for contributing to the project.

## Project Status

Reia is maintained as a **historical archive and research project** with ongoing maintenance for modern Erlang versions. We accept contributions focused on:

- ✅ **Maintenance**: Bug fixes, compatibility updates, build improvements
- ✅ **Documentation**: Guides, examples, clarifications
- ✅ **Testing**: Additional test cases, edge case coverage
- ✅ **Infrastructure**: CI/CD improvements, tooling
- ❌ **New Features**: The language itself is considered feature-complete

If you want to build on Reia's concepts, we recommend **[Elixir](https://github.com/elixir-lang/elixir)**, which actively evolves similar ideas.

## Getting Started

### Prerequisites

- Erlang 27, 28, or 29+
- Standard POSIX shell (bash, sh)
- Git

### Building from Source

```bash
# Clone the repository
git clone https://github.com/georgebaskervil/reia.git
cd reia

# Build
./build.sh build

# Run tests
./build.sh test

# Run benchmarks
./build.sh benchmark
```

## Making Changes

### Workflow

1. **Fork** the repository on GitHub
2. **Create a branch** for your changes: `git checkout -b fix/your-fix-name`
3. **Make your changes** and ensure tests pass: `./build.sh test`
4. **Commit** with a clear message: `git commit -m "Fix: clear description"`
5. **Push** to your fork and **submit a pull request**

### Commit Messages

Use clear, concise commit messages:

- `Fix: description` - Bug fixes
- `Docs: description` - Documentation updates
- `Test: description` - Test additions/improvements
- `Chore: description` - Build, CI, or tooling changes
- `Compat: description` - Erlang/OTP compatibility updates

Example:
```
Fix: Handle string interpolation in Erlang 29

Previous implementation relied on deprecated erlang:get_stacktrace/0.
Updated to use modern try/catch syntax compatible with Erlang 21+.

Fixes #123
```

### Code Style

- Follow existing patterns in the codebase
- Erlang code: 2-space indentation
- Use meaningful variable names
- Add comments for complex logic
- Keep functions focused and modular

### Testing

Before submitting a PR, ensure:

```bash
# All tests pass
./build.sh clean && ./build.sh test

# Benchmarks still work
./build.sh benchmark

# Clean build from scratch
./build.sh clean
./build.sh build
```

**Expected test results**: 101 assertions, 0 failures, 0 errors

## Types of Contributions

### Bug Reports

Found a bug? Please open an issue with:

- **Title**: Clear, concise description
- **Erlang version**: `erl -version`
- **Steps to reproduce**: Exact commands that trigger the bug
- **Expected behavior**: What should happen
- **Actual behavior**: What actually happens
- **Environment**: OS, shell, any other relevant info

### Documentation

Documentation improvements are always welcome:

- Clarify existing docs
- Add examples
- Write installation guides
- Document APIs
- Create troubleshooting guides

### Test Coverage

Help improve test coverage:

- Add tests for edge cases
- Add regression tests for bugs
- Improve test documentation
- Add benchmarks for performance-sensitive code

### Maintenance

Maintenance contributions are especially valuable:

- Erlang/OTP compatibility updates
- Build system improvements
- CI/CD enhancements
- Dependency updates
- Code cleanup

## Review Process

Once you submit a PR:

1. **Automated checks** run (GitHub Actions)
   - Build on Erlang 27, 28, 29
   - All tests must pass
   - Code quality checks

2. **Code review** from maintainers
   - We'll provide feedback if changes are needed
   - Suggestions for improvement

3. **Merge** once approved and all checks pass

## Questions?

- Open an issue for questions or discussions
- Check existing issues/PRs for similar topics
- Reference relevant sections of code when asking questions

## License

By contributing to Reia, you agree that your contributions will be licensed under the same MIT license as the project.

---

Thank you for helping maintain Reia! 🎉
