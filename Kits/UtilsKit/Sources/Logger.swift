//
//  Logger.swift
//  Meter Reader
//
//  Created by Dursun YILDIZ on 10.11.2023.
//

import Foundation
public enum Log {
    public enum LogLevel {
        case info
        case warning
        case error

        fileprivate var prefix: String {
            switch self {
            case .info: return "INFO"
            case .warning: return "WARN ⚠️"
            case .error: return "ALERT ❌"
            }
        }
    }

    public struct Context {
        let file: String
        let function: String
        let line: Int
        var description: String {
            "\((file as NSString).lastPathComponent):\(line) \(function)"
        }
    }

    public  static func info(_ str: String,
                     shouldLogContext: Bool = true,
                     file: String = #file,
                     function: String = #function,
                     line: Int = #line)
    {
        let context: Context = .init(file: file, function: function, line: line)
        Log.handleLog(level: .info, str: str.description, shouldLogContext: shouldLogContext, context: context)
    }

    public static func warning(_ str: String,
                        shouldLogContext: Bool = true,
                        file: String = #file,
                        function: String = #function,
                        line: Int = #line)
    {
        let context: Context = .init(file: file, function: function, line: line)
        Log.handleLog(level: .warning, str: str.description, shouldLogContext: shouldLogContext, context: context)
    }

    public  static func error(_ str: String,
                      shouldLogContext: Bool = true,
                      file: String = #file,
                      function: String = #function,
                      line: Int = #line)
    {
        let context: Context = .init(file: file, function: function, line: line)
        Log.handleLog(level: .error, str: str.description, shouldLogContext: shouldLogContext, context: context)
    }

    fileprivate static func handleLog(level: LogLevel, str: String, shouldLogContext: Bool, context: Context) {
        let logCompanents: [String] = ["[\(level.prefix)]", str]
        var fullString = logCompanents.joined(separator: " ")
        if shouldLogContext {
            fullString += " -> \(context.description)"
        }
        #if DEBUG
        // swiftlint:disable:next print_statements
            print(fullString)
        #endif
    }
}
