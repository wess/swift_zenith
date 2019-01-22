/**
 *  UINavigationController+Zenith.swift
 *  Zenith
 * 
 *  Created by Wess Cope (me@wess.io) on 09/05/19
 *  Copyright 2019 Wess Cope
 */


import Foundation
import UIKit

/// Extension for working with Zenith routes.

extension UINavigationController {
  /**
   Initialize a navigation controller with list of routes.
   
   - parameter routes: Array of routes for the navigation controller.
   */
  public convenience init(_ routes:[RouteOption]) {
    self.init(nibName: nil, bundle: nil)
    
    self.viewControllers = routes.map { $0.controller }
  }
  
  /**
   Initialize a navigation controller with a root route.
   
   - parameter root: Route you want as the root of navigation controller.
   */
  public convenience init(root:RouteOption) {
    self.init(rootViewController: root.controller)
  }
}
