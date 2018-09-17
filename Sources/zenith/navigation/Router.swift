/**
 *  Router.swift
 *  navigation
 * 
 *  Created by Wess Cope (me@wess.io) on 09/05/18
 *  Copyright 2018 WessCope
 */

import Foundation
import UIKit

public struct Router<T:RouteOption> {
  public init() {}
  
  public func navigate(_ route:T, from:UIViewController) {
    _navigate(route, from: from)
  }
  
  public func navigate(_ route:T) {
    guard let window = UIApplication.shared.keyWindow else {
      console.error("No window available")
      
      return
    }
    
    guard let from = window.rootViewController else { return }
    
    _navigate(route, from: from)
  }
  
  public func present(_ route:T, from:UIViewController) {
    _present(route, from: from)
  }
  
  public func move(_ route:T, animated:Bool = true) {
    guard let window = UIApplication.shared.keyWindow else {
      console.error("No window available")
      
      return
    }

    _move(route, with:window, animated:animated)
  }
  
  public func move(_ route:T, with:UIWindow, animated:Bool = true) {
    _move(route, with:with, animated:animated)
  }
}

extension Router /* Navigation */ {
  public func _navigate(_ route:T, from:UIViewController) {
    from.navigationController?.pushViewController(route.controller, animated:true)
  }
  
  public func _present(_ route:T, from:UIViewController) {
    (from.navigationController ?? from).show(route.controller, sender: nil)
  }
  
  public func _move(_ route:T, with:UIWindow, animated:Bool = true) {
    if animated {
      UIView.transition(with: with, duration: 0.5, options: .transitionCrossDissolve, animations: {
        with.rootViewController = route.controller
      }, completion: nil)
    } else {
      with.rootViewController = route.controller
    }
  }

}
