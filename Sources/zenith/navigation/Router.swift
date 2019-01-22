/**
 *  Router.swift
 *  Zenith
 * 
 *  Created by Wess Cope (me@wess.io) on 09/05/19
 *  Copyright 2019 Wess Cope
 */

import Foundation
import UIKit

/**
  Used for simplified navigation through the app.
 */
public struct Router<T:RouteOption> {
  /// Initialize a new router.
  public init() {}
  
  /**
    Navigate to a route from a specific view controller
   
    - parameter route: Where to navigate to.
    - parameter from: View controller to navigate from.
   */
  public func navigate(_ route:T, from:UIViewController) {
    _navigate(route, from: from)
  }
  
  /**
    Navigate to a specific location.
   
    - parameter route: Option to navigate to.
   */
  public func navigate(_ route:T) {
    guard let window = UIApplication.shared.keyWindow else {
      console.error("No window available")
      
      return
    }
    
    guard let from = window.rootViewController else { return }
    
    _navigate(route, from: from)
  }
  
  /**
    Present a route as a modal, from a specific view controller.
   
    - parameter route: Option to navigate to.
    - parameter from: View controller to navigate from.
   */
  public func present(_ route:T, from:UIViewController) {
    _present(route, from: from)
  }
  
  /**
    Assign the option's view controller as the key window's rootViewController.
   
    - parameter route: Option to move to the window's root.
    - parameter animated: Option to animate the replacement of the root view controller.
   */
  public func move(_ route:T, animated:Bool = true) {
    guard let window = UIApplication.shared.keyWindow else {
      console.error("No window available")
      
      return
    }

    _move(route, with:window, animated:animated)
  }
  
  /**
    Assign the option's view controller to a specific window.
   
    - parameter route: Option to move to the window's root.
    - parameter with: Window to assign  rootViewController of.
    - parameter animated: Option to animate the replacement of the root view controller.
   */
  public func move(_ route:T, with:UIWindow, animated:Bool = true) {
    _move(route, with:with, animated:animated)
  }
}

extension Router /* Navigation */ {
  internal func _navigate(_ route:T, from:UIViewController) {
    from.navigationController?.pushViewController(route.controller, animated:true)
  }
  
  internal func _present(_ route:T, from:UIViewController) {
    (from.navigationController ?? from).show(route.controller, sender: nil)
  }
  
  internal func _move(_ route:T, with:UIWindow, animated:Bool = true) {
    if animated {
      UIView.transition(with: with, duration: 0.5, options: .transitionCrossDissolve, animations: {
        with.rootViewController = route.controller
      }, completion: nil)
    } else {
      with.rootViewController = route.controller
    }
  }
}
