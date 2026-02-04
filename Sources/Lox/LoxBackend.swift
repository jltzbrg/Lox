import Logging
import OSLog
import Foundation

/// LoxBackend - OSLog backend implementation for SwiftLog
/// Provides native OSLog performance with elegant API
public struct LoxBackend: LogHandler {
    
    // MARK: - Properties
    
    public var logLevel: Logging.Logger.Level = .info
    public var metadata = Logging.Logger.Metadata()
    
    private let osLog: OSLog
    private let subsystem: String
    private let category: String
    
    // MARK: - Initialization
    
    /// Creates a new LoxBackend instance
    /// - Parameters:
    ///   - subsystem: The subsystem identifier (e.g., "com.yourapp")
    ///   - category: The category/label for this logger
    public init(subsystem: String = "com.yourapp", category: String) {
        self.subsystem = subsystem
        self.category = category
        self.osLog = OSLog(subsystem: subsystem, category: category)
    }
    
    // MARK: - LogHandler Protocol
    
    public subscript(metadataKey metadataKey: String) -> Logging.Logger.Metadata.Value? {
        get { metadata[metadataKey] }
        set { metadata[metadataKey] = newValue }
    }
    
    public func log(
        level: Logging.Logger.Level,
        message: Logging.Logger.Message,
        metadata: Logging.Logger.Metadata?,
        source: String,
        file: String,
        function: String,
        line: UInt
    ) {
        guard logLevel <= level else { return }
        
        let combinedMetadata = self.metadata.merging(metadata ?? [:]) { _, new in new }
        let formattedMessage = formatMessage(
            message,
            level: level,
            metadata: combinedMetadata,
            file: file,
            line: line
        )
        
        // Map SwiftLog levels to OSLog types
        let osLogType: OSLogType = mapLogLevel(level)
        let emoji = emojiForLevel(level)
        
        // Log to OSLog
        os_log("%{public}@ %{public}@", log: osLog, type: osLogType, emoji, formattedMessage)
    }
    
    // MARK: - Private Helpers
    
    /// Maps SwiftLog levels to OSLog types
    private func mapLogLevel(_ level: Logging.Logger.Level) -> OSLogType {
        switch level {
        case .trace:
            return .debug
        case .debug:
            return .debug
        case .info:
            return .info
        case .notice:
            return .info
        case .warning:
            return .default
        case .error:
            return .error
        case .critical:
            return .fault
        }
    }
    
    /// Returns the appropriate emoji for a log level
    private func emojiForLevel(_ level: Logging.Logger.Level) -> String {
        switch level {
        case .trace:
            return "🔍"
        case .debug:
            return "🔍"
        case .info:
            return "ℹ️"
        case .notice:
            return "📝"
        case .warning:
            return "⚠️"
        case .error:
            return "❌"
        case .critical:
            return "💥"
        }
    }
    
    /// Formats the message with metadata and source location for optimal Xcode Console display
    private func formatMessage(
        _ message: Logging.Logger.Message,
        level: Logging.Logger.Level,
        metadata: Logging.Logger.Metadata,
        file: String,
        line: UInt
    ) -> String {
        
        var components: [String] = []
        
        // Add category prefix
        components.append("[\(category)]")
        
        // Add the main message
        components.append(String(describing: message))
        
        // Add metadata as [key: value] format
        if !metadata.isEmpty {
            let metaString = metadata
                .sorted { $0.key < $1.key }
                .map { "\($0.key): \($0.value)" }
                .joined(separator: ", ")
            components.append("[\(metaString)]")
        }
        
        // Add source location (only in DEBUG builds)
        #if DEBUG
        let fileName = (file as NSString).lastPathComponent
        components.append("(\(fileName):\(line))")
        #endif
        
        return components.joined(separator: " ")
    }
}
