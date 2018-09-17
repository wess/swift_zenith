//
//  Component.swift
//  Zenith
//
//  Created by Wess Cope on 9/7/18.
//

import Foundation
import UIKit

public protocol Component {
  var view:UIView { get }
  
  init()
  func setupConstraints()
  func prepareForRender()
  func render() -> UIView
  func willAppear()
  func didAppear()
  func willDisappear()
  func didDisappear()
  func children(_ args:UIView...) -> UIView
}

public extension Component {
  public var view:UIView {
    return UIView()
  }
  
  public func prepareForRender() {}
  public func willAppear() {}
  public func didAppear() {}
  public func willDisappear() {}
  public func didDisappear() {}
  public func children(_ args:UIView...) -> UIView {
    args.forEach(self.view.addSubview)
    
    setupConstraints()
    
    return self.view
  }
}
