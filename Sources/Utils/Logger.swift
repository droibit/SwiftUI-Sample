// swiftlint:disable legacy_objc_type

internal import Foundation
internal import os

public enum Logger: Sendable {
  private static let logger = os.Logger(
    subsystem: Bundle.main.bundleIdentifier!,
    category: "default"
  )

  public static func info(
    _ message: @autoclosure () -> String,
    functionName: String = #function,
    fileName: String = #file,
    lineNumber: Int = #line
  ) {
    doLog(message(), level: .info, functionName: functionName, fileName: fileName, lineNumber: lineNumber)
  }

  public static func debug(
    _ message: @autoclosure () -> String,
    functionName: String = #function,
    fileName: String = #file,
    lineNumber: Int = #line
  ) {
    doLog(message(), level: .debug, functionName: functionName, fileName: fileName, lineNumber: lineNumber)
  }

  public static func error(
    _ message: @autoclosure () -> String,
    functionName: String = #function,
    fileName: String = #file,
    lineNumber: Int = #line
  ) {
    doLog(message(), level: .error, functionName: functionName, fileName: fileName, lineNumber: lineNumber)
  }

  public static func fault(
    _ message: @autoclosure () -> String,
    functionName: String = #function,
    fileName: String = #file,
    lineNumber: Int = #line
  ) {
    doLog(message(), level: .fault, functionName: functionName, fileName: fileName, lineNumber: lineNumber)
  }

  public static func `default`(
    _ message: @autoclosure () -> String,
    functionName: String = #function,
    fileName: String = #file,
    lineNumber: Int = #line
  ) {
    doLog(message(), level: .default, functionName: functionName, fileName: fileName, lineNumber: lineNumber)
  }

  private static func doLog(
    _ message: @autoclosure () -> String,
    level: OSLogType,
    functionName: String,
    fileName: String,
    lineNumber: Int
  ) {
    #if DEBUG
      let className = ((fileName as NSString).lastPathComponent as NSString).deletingPathExtension
      let output = "[\(className)#\(functionName):\(lineNumber)] \(message())"
      Self.logger.log(level: level, "\(output)")
    #endif
  }
}

public func currentQueueName() -> String {
  // ref. https://stackoverflow.com/questions/39553171/how-to-get-the-current-queue-name-in-swift-3/39809760
  if let name = String(cString: __dispatch_queue_get_label(nil), encoding: .utf8) {
    return name + ", isMainThread: \(Thread.current.isMainThread)"
  }
  return "unknown"
}
