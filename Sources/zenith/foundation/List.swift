/**
 *  List.swift
 *  foundation
 * 
 *  Created by Wess Cope (me@wess.io) on 08/03/18
 *  Copyright 2018 WessCope
 */

import Foundation

/// Functions that work on (linked) lists.
public struct List {
  private let context:[Any]
  
  public init(_ context:[Any]) {
    self.context = context
  }
  
  public static func objectAtIndex(_ list:List, index:Int) -> (List, Any) {
    return (list, list.context[index])
  }

  /**
  Deletes the give item from the list. Returns a new list without the item.
  If the item occurs more than once in the list, just the first occurence is removed.
  - parameter list: List that item is to be removed from.
  - parameter item: item to be removed from list
  - Returns: New list without removed item.
  */
  public static func delete(_ list:List, item:Any) -> List {
    let context = list.context.filter {
      let lhs = item as AnyObject
      let rhs = $0 as AnyObject
      
      return lhs.isEqual(rhs)
    }

    return List(context)
  }
  
  /**
  Produces a new list by removing the value at the specified index.
  - parameter list: List that item is to be removed from.
  - parameter at: Index of item to be removed
  - Returns: New list with item at index removed.
  */
  public static func delete(_ list:List, at:Int) -> List {
    var context = list.context
    
    context.remove(at: at)
    
    return List(context)
  }

  /**
  Duplicates the given element `n` times in a list.
  - parameter value: Element to be duplicated.
  - parameter times: Number of times to duplicate the value.
  - Returns: New list with repeated items.
  */
  public static func duplicate(_ value:Any, times:Int) -> List {
    var context = [Any]()
    
    for _ in 0...times {
      context.append(value)
    }
    
    return List(context)
  }

  /**
  Returns the first element in a list or nil if the list is empty.
  - parameter list: List to pull first item from.
  - Returns: List given and first item.
  */
  public static func first(_ list:List) -> (List, Any?) {
    return (list, list.context.first)
  }
  
  /**
  Flattens the given list of nested lists
  - parameter list: list to flatten
  - Returns: New list of linear items.
  */
  public static func flatten(_ list:List) -> List {
    return List(list.context.compactMap { $0 })
  }
  
  /**
  Flattens the given list of nested lists. The list tail will be added at the end of the flattened list.
  - parameter list: List to flatten.
  - Returns: New list of flattened items with appended list.
  */
  public static func flatten(_ list:List, tail:List) -> List {
    return List(List.flatten(list).context + tail.context)
  }
  
  /**
  Folds (reduces) the given list with a function. Requires an accumulator.
  - parameter list: List to fold.
  - parameter accumulator: item to fold list into.
  - parameter fun: function used to fold items in to accumulator
  - Returns: Item built from list.
  */
  public static func fold(_ list:List, accumulator:Any, fun:(Any, Any) -> Any) -> Any {
    return list.context.reduce(accumulator, fun)
  }
  
  public static func insertAt(_ list:List, index:Int, value:Any) -> List {
    var context = list.context
    context.insert(value, at: index)
    
    return List(context)
  }
  
  public static func keyDelete(_ list:List, key:String, position:Int) -> List {
    guard var context = list.context as? [(String, Any)],
          let index   = context.firstIndex(where: { (elem) -> Bool in elem.0 == key }) else {
      console.error("** Requires a list of tuples")
      fatalError()
    }

    context.remove(at: index)
    
    return List(context)
  }
  
  public static func keyFind(_ list:List, key:String, position:Int, default:Any? = nil) -> Any? {
    guard let context = list.context as? [(String, Any)],
      let index   = context.firstIndex(where: { (elem) -> Bool in elem.0 == key }) else {
        console.error("** Requires a list of tuples")
        fatalError()
    }
    
    return context[index]
  }
  
  public static func keyMember(_ list:List, key:String, position:Int) -> Bool {
    guard let context = list.context as? [(String, Any)] else {
        return false
    }

    return context.contains { (elem) -> Bool in
      elem.0 == key
    }
  }
  
  public static func keyReplace(_ list:List, key:String, position:Int, newValue:(String, Any)) -> List {
    guard var context = list.context as? [(String, Any)],
      let index   = context.firstIndex(where: { (elem) -> Bool in elem.0 == key }) else {
        console.error("** Requires a list of tuples")
        fatalError()
    }

    context[index] = newValue
    
    return List(context)
  }
  
  public static func keySort(_ list:List, position:Int) -> List {
    guard position < list.context.count, var context = list.context as? [(String, Any)] else {
        console.error("** Requires a list of tuples")
        fatalError()
    }

    let pre   = Array(context[...position])
    let post  = Array(context[position...])
    
    return List(pre + post)
  }
  
  public static func last(_ list:List) -> Any? {
    return list.context.last
  }
  
  public static func pop(_ list:List, at:Int) -> (List, Any?) {
    guard list.context.count < (at + 1) else {
      return (list, nil)
    }
    
    let value = list.context[at]
    var context = list.context
    
    context.remove(at: at)
    
    return (List(context), value)
  }
  
  public static func replace(_ list:List, at:Int, value:Any) -> List {
    guard list.context.count < (at + 1) else {
      return list
    }
    
    var context = list.context
    context[at] = value
    
    return List(context)
  }
  
  public static func startsWith(_ list:List, prefix:List) -> Bool {
    guard prefix.context.count <= list.context.count else { return false }
    
    for i in 0...prefix.context.count {
      guard (list.context[i] as AnyObject).isEqual((prefix.context[i] as AnyObject)) else {
        return false
      }
    }

    return true
  }
  
  public static func toString(_ list:List) -> String {
    return list.context.reduce("") {
      $0 + "\($1)"
    }
  }
  
  public static func update(_ list:List, at:Int, fun:((Any) -> Any)) -> List {
    guard list.context.count < (at + 1) else {
      return list
    }

    let value   = list.context[at]
    var context = list.context
    
    context[at] = fun(value)
    
    return List(context)
  }
  
  public static func wrap(_ element:Any) -> List {
    if let list = element as? List {
      return list
    }
    
    return List([element])
  }
  
  public static func zip(_ lhs:List, _ rhs:List) -> List {
    return List(Array(Swift.zip(lhs.context, rhs.context)))
  }
}
