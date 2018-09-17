/**
 *  console.swift
 *  foundation
 * 
 *  Created by Wess Cope (me@wess.io) on 09/05/18
 *  Copyright 2018 WessCope
 */

import Foundation

/// Enhanced logging/printing when debugging.

public struct console {
  private static let infoCharacter    = "ℹ️"
  private static let debugCharacter   = "🐞"
  private static let successCharacter = "✅"
  private static let warningCharacter = "⚠️"
  private static let errorCharacter   = "❗️"
  private static let fatalCharacter   = "‼️"

  public static let log = console.info
  
  /**
  Logs to console showing file, line number, function, and message, with indicator ℹ️.
  - parameter args: message and items you want to print
  - parameter line: line number where called.
  - parameter file: file where called
  - parameter function: function where called.
  - Note: line, file and function are all defaulted to build-ins and should not be passed to function.
  */
  public static func info(_ args:String..., line:Int = #line, file:String = #file, function:String = #function) {
    console.safePrint(
      (infoCharacter + " \(line) : \((file.split(separator: "/").last ?? "")) : \(function) :: " + buildMessage(args))
    )
  }
  
  /**
  Logs to console showing file, line number, function, and message, with indicator 🐞.
  - parameter args: message and items you want to print
  - parameter line: line number where called.
  - parameter file: file where called
  - parameter function: function where called.
  - Note: line, file and function are all defaulted to build-ins and should not be passed to function.
  */
  public static func debug(_ args:String..., line:Int = #line, file:String = #file, function:String = #function) {
    console.safePrint(
      (debugCharacter + " \(line) : \((file.split(separator: "/").last ?? "")) : \(function) :: " + buildMessage(args))
    )
  }
  
  /**
  Logs to console showing file, line number, function, and message, with indicator ✅.
  - parameter args: message and items you want to print
  - parameter line: line number where called.
  - parameter file: file where called
  - parameter function: function where called.
  - Note: line, file and function are all defaulted to build-ins and should not be passed to function.
  */
  public static func success(_ args:String..., line:Int = #line, file:String = #file, function:String = #function) {
    console.safePrint(
      (successCharacter + " \(line) : \((file.split(separator: "/").last ?? "")) : \(function) :: " + buildMessage(args))
    )
  }
  
  /**
  Logs to console showing file, line number, function, and message, with indicator ️⚠️.
  - parameter args: message and items you want to print
  - parameter line: line number where called.
  - parameter file: file where called
  - parameter function: function where called.
  - Note: line, file and function are all defaulted to build-ins and should not be passed to function.
  */
  public static func warning(_ args:String..., line:Int = #line, file:String = #file, function:String = #function) {
    console.safePrint(
      (warningCharacter + " \(line) : \((file.split(separator: "/").last ?? "")) : \(function) :: " + buildMessage(args))
    )
  }
  
  /**
  Logs to console showing file, line number, function, and message, with indicator ❗️.
  - parameter args: message and items you want to print
  - parameter line: line number where called.
  - parameter file: file where called
  - parameter function: function where called.
  - Note: line, file and function are all defaulted to build-ins and should not be passed to function.
  */
  public static func error(_ args:String..., line:Int = #line, file:String = #file, function:String = #function) {
    console.safePrint(
      (errorCharacter + " \(line) : \((file.split(separator: "/").last ?? "")) : \(function) :: " + buildMessage(args))
    )
  }
  
  private static func buildMessage(_ args:[Any]) -> String {
    let parts = args.map { part in
      return "\(part)"
    }
    
    return parts.joined(separator: " ")
  }
  
  private static func safePrint(_ message:String) {
    #if DEBUG
    
    print(message)
    
    #endif
  }
}
