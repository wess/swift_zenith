/**
 *  Identifiable.swift
 *  foundation
 * 
 *  Created by Wess Cope (me@wess.io) on 09/05/18
 *  Copyright 2018 WessCope
 */

/// Protocol to add element name as identifier.

public protocol Identifiable {
  /// Static identifier based on extension name.
  static var identifier:String  { get }
  
  /// instance identifier based on extension name.
  var identifier:String         { get }
}

extension Identifiable {
  public static var identifier:String {
    return String(describing: self)
  }
  
  public var identifier:String {
    return type(of: self).identifier
  }
}
