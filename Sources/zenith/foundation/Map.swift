/**
 *  Map.swift
 *  foundation
 * 
 *  Created by Wess Cope (me@wess.io) on 08/03/18
 *  Copyright 2018 WessCope
 */

import Foundation

public struct Map {
  private let context:[String:Any]

  public init() {
    self.context = [:]
  }

  public init(_ context:[String:Any]) {
    self.context = Dictionary(uniqueKeysWithValues: zip(context.keys, context.values))
  }

  public init(_ list:[[String:Any]]) {
    self.context = list.reduce([String:Any]()) { (result, current) in
      var _result = result
      _result.merge(current) { $1 }
      
      return _result
    }
  }
  
  public init(_ list:[Any], transform:((Any) -> ((key:String, value:Any)))) {
    self.context = list.reduce([String:Any]()) { (result, current) in
      let pair    = transform(current)
      var _result = result
      
      _result[pair.key] = pair.value
      
      return _result
    }
  }
  
  public static func count(_ map:Map) -> Int {
    return map.context.count
  }
  
  public static func delete(_ map:Map, key:String) -> Map {
    var context = map.context
    
    context.removeValue(forKey: key)
    
    return Map(context)
  }
  
  public static func drop(_ map:Map, keys:[String]) -> Map {
    let context = map.context.filter {
      !keys.contains($0.key)
    }
    
    
    return Map(context)
  }
  
  public static func equal(_ lhs:Map, _ rhs:Map) -> Bool {
    return (lhs.context as NSDictionary).isEqual(to: rhs.context)
  }
  
  public static func fetch(_ map:Map, key:String) -> Any {
    guard let value = map.context[key] else {
      console.error("** (KeyError) key: \(key) not found in \(map.context)")
      
      fatalError()
    }
    return value
  }
  
  public static func get(_ map:Map, key:String, default:Any? = nil) -> (Map, Any?) {
    guard let value = map.context[key] else {
      return (map, `default`)
    }
    
    return (map, value)
  }
  
  public static func getAndUpdate(_ map:Map, key:String, fun:((Any) -> Any?)) -> Map {
    guard let value = map.context[key] else {
      console.error("** (KeyError) key: \(key) not found in \(map.context)")
      
      fatalError()
    }
    
    var context = map.context
    
    context[key] = fun(value)
    
    return Map(context)
  }
  
  public static func getLazy(_ map:Map, key:String, fun:(() -> Any?)) -> (Map, Any?) {
    guard let value = map.context[key] else {
      return (map, fun())
    }
    
    return (map, value)
  }
  
  public static func from<T:Encodable>(struct st:T) throws -> Map {
    do {
      let encoder = JSONEncoder()
      let data    = try encoder.encode(st)
      let dict    = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
    
      guard let context = dict as? [String:Any] else {
        console.error("** Unable to convert struct to map")
        
        fatalError()
      }
    
      return Map(context)
    } catch {
      console.error("** Unable to convert struct to map")
      
      fatalError()
    }
  }
  
  public static func hasKey(_ map:Map, key:String) -> (Map, Bool) {
    return (map, map.context.index(forKey: key) != nil)
  }
  
  public static func keys(_ map:Map) -> (Map, [String]) {
    return (map, map.context.keys.map { String($0) })
  }
  
  public static func values(_ map:Map) -> (Map, [Any]) {
    return (map, Array(map.context.values))
  }
  
  public static func merge(_ lhs:Map, _ rhs:Map, fun:((String, Any, Any) -> (Any))? = nil) -> Map {
    var context = lhs.context
    
    if let fun = fun {
      context = context.reduce([String:Any]()) { (result, current) in
        var _result = result
        _result[current.key] = fun(
                                  current.key,
                                  Map.fetch(lhs, key: current.key),
                                  Map.fetch(rhs, key: current.key)
                                )
        
        return _result
      }
    } else {
      context.merge(rhs.context) { $1 }
    }
    
    return Map(context)
  }
  
  public static func pop(_ map:Map, key:String, default:Any? = nil) -> (Map, Any?) {
    guard let value = map.context[key] else {
      return (map, `default`)
    }
    
    var context = map.context
    context.removeValue(forKey: key)
    
    return (Map(context), value)
  }
  
  public static func popLazy(_ map:Map, key:String, fun:(() -> Any?)) -> (Map, Any?) {
    guard let _ = map.context[key] else {
      return (map, fun())
    }
    
    return Map.pop(map, key:key)
  }
  
  public static func put(_ map:Map, key:String, value:Any) -> Map {
    var context = map.context
    
    context[key] = value
    
    return Map(context)
  }
  
  public static func putNew(_ map:Map, key:String, value:Any) -> Map {
    guard Map.hasKey(map, key: key).1 == false else {
      return map
    }
    
    return Map.put(map, key:key, value:value)
  }
  
  public static func putNewLazy(_ map:Map, key:String, fun:(() -> (Any))) -> Map {
    guard Map.hasKey(map, key: key).1 == false else {
      return map
    }
    
    var context = map.context
    context[key] = fun()
    
    return Map(context)
  }
  
  public static func replace(_ map:Map, key:String, value:Any) -> Map {
    guard Map.hasKey(map, key: key).1 == true else {
      console.error("** (KeyError) key: \(key) not found in \(map.context)")
      
      fatalError()
    }
    
    return Map.put(map, key:key, value:value)
  }
  
  public static func split(_ map:Map, keys:[String]) -> (Map, Map) {
    var context       = map.context
    var splitContext  = [String:Any]()
    
    for key in keys {
      guard let value = context[key] else {
        continue
      }
      
      splitContext[key] = value
      context.removeValue(forKey: key)
    }
    
    return (Map(context), Map(splitContext))
  }
  
  public static func take(_ map:Map, keys:[String]) -> Map {
    let context = map.context.filter {
      keys.contains($0.key)
    }
    
    return(Map(context))
  }
  
  public static func toList(_ map:Map) -> (Map, [(String, Any)]) {
    let list = map.context.reduce([(String, Any)]()) { result, current in
      result + [(current.key, current.value)]
    }

    return (map, list)
  }
  
  public static func update(_ map:Map, key:String, fun:((Any) -> (Any))) -> Map {
    guard let value = map.context[key] else {
      console.error("** (KeyError) key: \(key) not found in \(map.context)")
      
      fatalError()
    }

    var context = map.context
    
    context[key] = fun(value)
    
    
    return Map(context)
  }
  
  public static func update(_ map:Map, key:String, initial:Any, fun:((Any) -> (Any))) -> Map {
    
    let value   = map.context[key] ?? initial
    var context = map.context
    
    context[key] = fun(value)
    
    
    return Map(context)
  }
}
