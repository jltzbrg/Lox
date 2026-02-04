# Lox 🦊

**Elegant OSLog Backend for SwiftLog** – Minimalist, type-safe, Xcode Console optimized.

[![Swift 5.9+](https://img.shields.io/badge/Swift-5.9%2B-orange.svg)](https://swift.org)
[![Platforms](https://img.shields.io/badge/platforms-iOS%20%7C%20macOS%20%7C%20watchOS%20%7C%20tvOS-blue.svg)](https://swift.org)
[![License](https://img.shields.io/badge/license-MIT-green.svg)](LICENSE)

---

## 🚀 Quickstart (4 lines)

```swift
// 1. Add to Package.swift
.package(url: "https://github.com/jltzbrg/Lox.git", from: "1.0.0")

// 2. App init (once)
Lox.bootstrap(subsystem: "com.yourcompany.app")

// 3. Use anywhere
let network = Lox.logger("Network")
network.info("API call", metadata: ["status": 200, "count": 42])
```

**That's it.** Zero config. Native OSLog performance.

---

## ✨ Features

| Feature                      | ✅ Done                       |
| :--------------------------- | :---------------------------- |
| **SwiftLog 100% compatible** | Works with existing code      |
| **OSLog Backend**            | Apple's native performance    |
| **Rich Metadata**            | `[key: value]` format         |
| **Xcode Console Optimized**  | File:Line references          |
| **Auto Privacy**             | debug=.private, error=.public |
| **Zero Runtime Cost**        | Release builds optimized      |

---

## 📱 Xcode Console Output

```
🔍 [Network] API call [status: 200, count: 42] (Network.swift:25)
⚠️ [UI] Button tap [userId: 123] (ContentView.swift:42)
❌ [API] Request failed [error: timeout] (APIClient.swift:78)
```

**Filter by:** `subsystem:Lox`, `Network`, `status:200`, click file links.

---

## 🛠 Installation

### Swift Package Manager

```swift
dependencies: [
    .package(url: "https://github.com/jltzbrg/Lox.git", from: "1.0.0")
]
```

### Xcode

1. **File → Add Package Dependencies**
2. `https://github.com/jltzbrg/Lox.git`
3. **Up to Next Major**: `1.0.0`

---

## 🎛 API Reference

### Core (Zero Learning Curve)

```swift
// Bootstrap (AppDelegate/once)
Lox.bootstrap(subsystem: "com.yourapp")

// Logger factory
let logger = Lox.logger("Network", level: .debug)

// Standard logging (SwiftLog compatible)
logger.info("User loaded", metadata: ["id": 123])
logger.error("API failed", metadata: ["code": 500])
```

### Power Features

```swift
// Fluent extensions
logger.loxInfo("Quick info log")
logger.loxDebug("Private debug info")
logger.loxError("Error with context")

// Custom log level
logger.lox(level: .warning, "Custom warning", metadata: ["threshold": 80])
```

---

## 🎯 Why Lox?

| Problem         | `print()` | OSLog Raw      | **Lox**        |
| :-------------- | :-------- | :------------- | :------------- |
| **Setup**       | 0s        | 2min           | **4s**         |
| **Readability** | ⭐        | ⭐⭐⭐         | **⭐⭐⭐⭐⭐** |
| **Metadata**    | ❌        | ⭐             | **⭐⭐⭐⭐⭐** |
| **Filterable**  | ❌        | ⭐⭐           | **⭐⭐⭐⭐⭐** |
| **Performance** | ⭐⭐      | **⭐⭐⭐⭐⭐** | **⭐⭐⭐⭐⭐** |

**Replace `print()` forever.**

---

## 🧪 Testing & CI

```bash
# Install dependencies
swift package resolve

# Build & Test
swift build
swift test

# Generate Xcode project
swift package generate-xcodeproj
```

---

## 📋 Requirements

- **iOS 15.0+** / **macOS 12.0+** / **watchOS 8.0+** / **tvOS 15.0+**
- **Swift 5.9+**
- **Xcode 15+**

---

## 📁 Project Structure

```
Lox/
├── Package.swift
├── Sources/
│   └── Lox/
│       ├── Lox.swift          # Main API
│       └── LoxBackend.swift   # OSLog Backend
├── Tests/
│   └── LoxTests/
│       └── LoxTests.swift     # Unit Tests
└── README.md
```

---

## 📈 Roadmap

| Version   | Features                       | Date    |
| :-------- | :----------------------------- | :------ |
| **1.0.0** | Core + Metadata                | ✅ Live |
| **1.1.0** | Hierarchical Logger + Emojis   | Q1 2026 |
| **1.2.0** | Performance Timing             | Q2 2026 |
| **2.0.0** | Network Logger + Crash Context | Q4 2026 |

---

## 🤝 Contributing

1. Fork → Clone → Create Feature Branch
2. `swift test` (must pass)
3. PR to `main`

**Small PRs welcome!** 🦊

---

## 📄 License

[MIT](LICENSE) © 2026

---

<div align="center">
Built with ❤️ for Swift developers who hate debugging
</div>

---

**Replace your `print()` statements today.** Stars ⭐ much appreciated!
