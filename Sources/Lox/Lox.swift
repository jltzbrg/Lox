import Logging
import OSLog

/// 🚀 Lox - Elegant OSLog Backend for SwiftLog
/// Minimalist, type-safe, Xcode Console optimized logging
public struct Lox {
    
    /// Bootstraps the Lox logging system with the given subsystem
    /// Call this once in your App's initialization (e.g., in AppDelegate or @main)
    /// - Parameter subsystem: The subsystem identifier (e.g., "com.yourcompany.app")
    public static func bootstrap(subsystem: String = "com.yourapp") {
        LoggingSystem.bootstrap { label in
            LoxBackend(subsystem: subsystem, category: label)
        }
    }
    
    /// Creates a new Logger with the specified label and optional log level
    /// - Parameters:
    ///   - label: The category/label for this logger (e.g., "Network", "UI")
    ///   - level: The minimum log level (default: .info)
    /// - Returns: A configured Logger instance
    public static func logger(_ label: String, level: Logging.Logger.Level = .info) -> Logging.Logger {
        var logger = Logging.Logger(label: label)
        logger.logLevel = level
        return logger
    }
}

// MARK: - Logger Extensions

public extension Logging.Logger {
    
    /// Logs a message with the specified level and metadata
    /// - Parameters:
    ///   - level: The log level
    ///   - message: The message to log
    ///   - metadata: Optional metadata dictionary
    ///   - file: Source file (auto-filled)
    ///   - function: Function name (auto-filled)
    ///   - line: Line number (auto-filled)
    func lox(
        level: Logging.Logger.Level,
        _ message: @autoclosure () -> String,
        metadata: Logging.Logger.Metadata? = nil,
        file: String = #file,
        function: String = #function,
        line: UInt = #line
    ) {
        self.log(
            level: level,
            Logging.Logger.Message(stringLiteral: message()),
            metadata: metadata,
            source: nil,
            file: file,
            function: function,
            line: line
        )
    }
    
    /// Quick info log with Lox prefix
    func loxInfo(
        _ message: @autoclosure () -> String,
        metadata: Logging.Logger.Metadata? = nil,
        file: String = #file,
        line: UInt = #line
    ) {
        lox(level: .info, message(), metadata: metadata, file: file, line: line)
    }
    
    /// Quick debug log with Lox prefix (private in release builds)
    func loxDebug(
        _ message: @autoclosure () -> String,
        metadata: Logging.Logger.Metadata? = nil,
        file: String = #file,
        line: UInt = #line
    ) {
        lox(level: .debug, message(), metadata: metadata, file: file, line: line)
    }
    
    /// Quick error log with Lox prefix
    func loxError(
        _ message: @autoclosure () -> String,
        metadata: Logging.Logger.Metadata? = nil,
        file: String = #file,
        line: UInt = #line
    ) {
        lox(level: .error, message(), metadata: metadata, file: file, line: line)
    }
}

// MARK: - Metadata Helpers

public extension Logging.Logger.Metadata {
    /// Creates metadata from a dictionary literal with automatic value conversion
    static func from(_ dictionary: [String: Any]) -> Logging.Logger.Metadata {
        var metadata = Logging.Logger.Metadata()
        for (key, value) in dictionary {
            metadata[key] = Logging.Logger.MetadataValue(stringLiteral: String(describing: value))
        }
        return metadata
    }
}
