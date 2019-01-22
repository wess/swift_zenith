/**
 *  ViewComponent.swift
 *  Zenith
 * 
 *  Created by Wess Cope (me@wess.io) on 09/05/19
 *  Copyright 2019 Wess Cope
 */

import Foundation
import UIKit

/**
 Subclassed and provided to ViewController for handling view setup, layout, etc. When subclassing
 `setupConstraints` and `render` are required with optional subclassed methods:
 `prepareForRender`, `willAppear`, `didAppear`, `willDisappear` and `didDisappear` for working with different stages
 of the component's life cycle.
 
 */
open class ViewComponent : NSObject {
  private let _view = UIView()
  
  /// The primary, host,  view of the component. Set to the view controller's view during `loadView`
  public var view:UIView {
    return _view
  }
  
  /// Called for laying out subviews and setting up constraints during render.
  open func setupConstraints() {
    fatalError("Must be overriden in child")
  }
  
  /// Renders the host view and subviews for presentation.
  open func render() -> UIView {
    fatalError("Must be overriden in child")
  }
  
  required override public init() {
    super.init()
    
    view.backgroundColor = .white
  }
  
  /**
    Called in render and identifies subviews to be laid out and added to
    host view.
   
    - parameter args: List of views, in order to be added, to add to component view.
    - returns: Component's main view.
   */
  public final func children(_ args:UIView...) -> UIView {
    args.forEach(self.view.addSubview)

    setupConstraints()
    
    return self.view
  }
}

extension ViewComponent /* optionals */ {
  /// Called right before the view component adds subviews, lays them out and presents them.
  public func prepareForRender()  {}
  
  /// Notifies the view component that it's view is about to be added to the view hiearchy.
  public func willAppear()        {}
  
  /// Notifies the view component that it's view appeared in the view hierarchy.
  public func didAppear()         {}
  
  /// Notifies the view component that it's view is about to be removed from a view hierarchy.
  public func willDisappear()     {}
  
  /// Notifies the view component that its view was removed from a view hierarchy.
  public func didDisappear()      {}
}
