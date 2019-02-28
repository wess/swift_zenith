/**
 *  RouteOption.swift
 *  Zenith
 * 
 *  Created by Wess Cope (me@wess.io) on 09/05/19
 *  Copyright 2019 Wess Cope
 */

import Foundation
import UIKit

/**
  Protocol that defines options the app can navigate through.

  ```swift
  enum MyRoute : RouteOption {
    case home
    case about

    var controller:UIViewController {
      switch self {
        case .home:
          return UINavigationController(rootViewController: MyHomeViewController)
        case .about:
          return UINavigationController(rootViewController: MyAboutViewController)
      }
    }
  }
  ```
 */

public protocol RouteOption {
  /// Controller to represent the route.
  var controller:UIViewController { get }
  
  /// Identifier of route
  var identifier:String { get }
}

extension RouteOption {
  public var identifier:String {
    return String(describing: type(of: self.controller))
  }
}

