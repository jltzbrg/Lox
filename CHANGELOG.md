# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added

- Document next features here

---

## [1.0.0] - 2026-02-04

### Added

- **Core API**: `Lox.bootstrap()` for global initialization
- **Logger Factory**: `Lox.logger()` for creating logger instances
- **OSLog Backend**: Native OSLog integration for optimal performance
- **Log-Level Support**: Full support for trace, debug, info, notice, warning, error, critical
- **Metadata Formatting**: Structured `[key: value]` output in console
- **Emoji Prefixes**: Visual identification of log levels (🔍 ℹ️ ⚠️ ❌ 💥)
- **Source Location**: Automatic file:line references in DEBUG builds
- **Fluent API**: Convenience methods `loxInfo()`, `loxDebug()`, `loxError()`
- **Log-Level Filtering**: Configurable minimum log level per logger
- **SwiftLog Compatibility**: 100% compatible with swift-log
- **Platform Support**: iOS 15+, macOS 12+, watchOS 8+, tvOS 15+
- **Unit Tests**: 8 tests for all core functionality
- **Documentation**: Complete README with quickstart and API reference

### Technical

- Requires Swift 5.9+
- Dependency: swift-log ^1.5.4
- Zero-config setup with 4-line integration

---

## Release Links

- [Unreleased]: https://github.com/jltzbrg/Lox/compare/1.0.0...HEAD
- [1.0.0]: https://github.com/USER/jltzbrg/releases/tag/1.0.0

---

**History:**

```
1.0.0 - 2026-02-04 - Initial Release
```
