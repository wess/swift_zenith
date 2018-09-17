/**
 *  ViewComponent.swift
 *  ui
 * 
 *  Created by Wess Cope (me@wess.io) on 09/05/18
 *  Copyright 2018 WessCope
 */

import Foundation
import UIKit

open class ViewComponent : NSObject, Component {
  private let _view = UIView()
  
  public var view:UIView {
    return _view
  }
  
  open func setupConstraints() {
    fatalError("Must be overriden in child")
  }
  
  open func prepareForRender() {}
  
  open func render() -> UIView {
    fatalError("Must be overriden in child")
  }
  
  required override public init() {
    super.init()
    
    view.backgroundColor = .white
  }
  
  open func willAppear() {}
  open func didAppear() {}
  open func willDisappear() {}
  open func didDisappear() {}
}
