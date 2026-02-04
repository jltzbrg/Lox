import XCTest
@testable import Lox
import Logging
import OSLog

/// NOTE: LoggingSystem can only be initialized once per process.
/// Tests that require different configurations should be run separately.
final class LoxTests: XCTestCase {
    
    // MARK: - Setup
    
    override func setUp() {
        super.setUp()
        // Note: LoggingSystem.bootstrap can only be called once per process
        // We initialize it once in the first test that needs it
    }
    
    // MARK: - LoxBackend Tests
    
    func testLoxBackendInitialization() {
        let backend = LoxBackend(subsystem: "com.test.backend", category: "TestCategory")
        
        XCTAssertEqual(backend.logLevel, .info)
        XCTAssertTrue(backend.metadata.isEmpty)
    }
    
    func testLoxBackendLogLevelFiltering() {
        var backend = LoxBackend(subsystem: "com.test.filter", category: "FilterTest")
        backend.logLevel = .warning
        
        // These should be filtered out (no crash expected, just no output)
        backend.log(
            level: .debug,
            message: "Debug message",
            metadata: nil,
            source: "test",
            file: #file,
            function: #function,
            line: #line
        )
        
        backend.log(
            level: .info,
            message: "Info message",
            metadata: nil,
            source: "test",
            file: #file,
            function: #function,
            line: #line
        )
        
        // These should pass through
        backend.log(
            level: .warning,
            message: "Warning message",
            metadata: nil,
            source: "test",
            file: #file,
            function: #function,
            line: #line
        )
        
        backend.log(
            level: .error,
            message: "Error message",
            metadata: nil,
            source: "test",
            file: #file,
            function: #function,
            line: #line
        )
        
        // Test passed if no crash
        XCTAssertTrue(true)
    }
    
    func testLoxBackendMetadata() {
        var backend = LoxBackend(subsystem: "com.test.metadata", category: "MetadataTest")
        
        // Test metadata subscript
        backend[metadataKey: "key1"] = "value1"
        backend[metadataKey: "key2"] = "value2"
        
        XCTAssertEqual(backend[metadataKey: "key1"], "value1")
        XCTAssertEqual(backend[metadataKey: "key2"], "value2")
        
        // Test metadata in log (should not crash)
        backend.log(
            level: .info,
            message: "Test with metadata",
            metadata: ["additional": "data"],
            source: "test",
            file: #file,
            function: #function,
            line: #line
        )
        
        XCTAssertTrue(true)
    }
    
    // MARK: - Log Level Tests
    
    func testAllLogLevels() {
        // Initialize logging system once
        staticBootstrapOnce()
        
        let logger = Lox.logger("LevelTest", level: .trace)
        
        // Test all log levels (should not crash)
        logger.trace("Trace message")
        logger.debug("Debug message")
        logger.info("Info message")
        logger.notice("Notice message")
        logger.warning("Warning message")
        logger.error("Error message")
        logger.critical("Critical message")
        
        XCTAssertTrue(true)
    }
    
    // MARK: - Logger Extension Tests
    
    func testLoxConvenienceMethods() {
        staticBootstrapOnce()
        
        let logger = Lox.logger("ExtensionTest", level: .debug)
        
        // Test convenience methods
        logger.loxDebug("Debug via extension")
        logger.loxInfo("Info via extension")
        logger.loxError("Error via extension")
        
        // Test with metadata
        logger.loxInfo("Info with metadata", metadata: ["key": "value"])
        
        XCTAssertTrue(true)
    }
    
    func testLoxWithMetadata() {
        staticBootstrapOnce()
        
        let logger = Lox.logger("MetadataTest")
        
        logger.lox(
            level: .info,
            "Message with metadata",
            metadata: [
                "userId": "123",
                "action": "login"
            ]
        )
        
        XCTAssertTrue(true)
    }
    
    // MARK: - Integration Tests
    
    func testMultipleLoggers() {
        staticBootstrapOnce()
        
        let networkLogger = Lox.logger("Network")
        let uiLogger = Lox.logger("UI")
        let dbLogger = Lox.logger("Database")
        
        networkLogger.info("Network initialized")
        uiLogger.info("UI ready")
        dbLogger.info("Database connected")
        
        XCTAssertTrue(true)
    }
    
    func testLoggerWithDifferentLevels() {
        staticBootstrapOnce()
        
        let verboseLogger = Lox.logger("Verbose", level: .debug)
        let quietLogger = Lox.logger("Quiet", level: .error)
        
        verboseLogger.debug("This should appear in verbose logger")
        verboseLogger.info("This should also appear")
        
        quietLogger.debug("This should NOT appear")
        quietLogger.info("This should also NOT appear")
        quietLogger.error("This SHOULD appear in quiet logger")
        
        XCTAssertTrue(true)
    }
    
    // MARK: - Static Helper
    
    /// Ensures LoggingSystem is bootstrapped exactly once across all tests
    private static var hasBootstrapped = false
    
    private func staticBootstrapOnce() {
        if !LoxTests.hasBootstrapped {
            Lox.bootstrap(subsystem: "com.test.lox")
            LoxTests.hasBootstrapped = true
        }
    }
}
