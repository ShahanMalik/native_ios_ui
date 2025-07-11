# Contributing to native_ios_ui

Thank you for your interest in contributing to native_ios_ui! This document provides guidelines for contributing to the project.

## Getting Started

### Prerequisites

- Flutter SDK (latest stable version)
- Xcode 14.0 or later
- iOS 13.0 or later for testing
- Git

### Setup

1. Fork the repository
2. Clone your fork:
   ```bash
   git clone https://github.com/ShahanMalik/native_ios_ui.git
   cd native_ios_ui
   ```
3. Install dependencies:
   ```bash
   flutter pub get
   cd example
   flutter pub get
   ```

## Development Workflow

### Making Changes

1. Create a new branch for your feature/fix:
   ```bash
   git checkout -b feature/your-feature-name
   ```

2. Make your changes following the coding standards below

3. Test your changes:
   ```bash
   flutter test
   cd example
   flutter build ios --no-codesign
   ```

4. Format your code:
   ```bash
   dart format .
   ```

5. Analyze your code:
   ```bash
   flutter analyze
   ```

### Testing

- Run unit tests: `flutter test`
- Test the example app on iOS simulator/device
- Verify all features work as expected

### Code Style

- Follow [Dart style guide](https://dart.dev/guides/language/effective-dart/style)
- Use `dart format` to format your code
- Add documentation comments for public APIs
- Keep functions small and focused

### Commit Messages

Use conventional commit messages:
- `feat:` for new features
- `fix:` for bug fixes
- `docs:` for documentation changes
- `style:` for formatting changes
- `refactor:` for code refactoring
- `test:` for test additions
- `chore:` for maintenance tasks

Example: `feat: add custom tab bar appearance support`

## Pull Request Process

1. Update the README.md with details of changes if needed
2. Update the CHANGELOG.md following the existing format
3. Ensure all tests pass
4. Update documentation if you've changed APIs
5. Submit a pull request with a clear description

### Pull Request Template

```markdown
## Description
Brief description of the changes

## Type of Change
- [ ] Bug fix
- [ ] New feature
- [ ] Breaking change
- [ ] Documentation update

## Testing
- [ ] Unit tests pass
- [ ] Example app builds and runs
- [ ] Manual testing completed

## Checklist
- [ ] Code follows style guidelines
- [ ] Self-review completed
- [ ] Documentation updated
- [ ] Tests added/updated
```

## Reporting Issues

### Bug Reports

Use the bug report template and include:
- Flutter version
- iOS version
- Device/simulator information
- Steps to reproduce
- Expected vs actual behavior
- Error messages/logs

### Feature Requests

Use the feature request template and include:
- Use case description
- Proposed solution
- Alternative solutions considered
- Additional context

## Code of Conduct

### Our Pledge

We are committed to providing a welcoming and inspiring community for all.

### Our Standards

- Be respectful and inclusive
- Focus on constructive feedback
- Gracefully accept criticism
- Show empathy towards others

### Enforcement

Unacceptable behavior may result in temporary or permanent exclusion from the project.

## Questions?

Feel free to open an issue for questions or reach out to the maintainers.

Thank you for contributing! 🚀
