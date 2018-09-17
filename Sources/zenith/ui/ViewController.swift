/**
 *  ViewController.swift
 *  ui
 * 
 *  Created by Wess Cope (me@wess.io) on 09/05/18
 *  Copyright 2018 WessCope
 */

import Foundation
import UIKit

open class ViewController<C : Component>: UIViewController, UINavigationBarDelegate {
  public let component:C
  
  private var _viewLoaded = false
  
  public init() {
    self.component  = C()
    
    super.init(nibName: nil, bundle: nil)
  }
  
  required public init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override open func loadView() {
    guard _viewLoaded == false else {
      return
    }
    
    let frame:CGRect
    
    if let parent = self.parent {
      frame = parent.view.bounds
    } else {
      frame = UIScreen.main.bounds
    }
    
    component.prepareForRender()
    
    let componentView     = component.render()
    componentView.frame   = frame
    
    self.view = componentView
    
    self.view.setNeedsUpdateConstraints()
    self.view.updateConstraintsIfNeeded()
  }
  
  override open func viewDidLoad() {
    super.viewDidLoad()
    
    self.view.backgroundColor = .white
  }
  
  override open func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    self.component.willAppear()
  }
  
  override open func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
    self.component.didAppear()
  }
  
  override open func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    
    self.component.willDisappear()
  }
  
  override open func viewDidDisappear(_ animated: Bool) {
    super.viewDidDisappear(animated)
    
    self.component.didDisappear()
  }
  
  
  @objc public func backAction(_ sender:Any?) {
    pop()
  }
}

extension ViewController /* navigation */ {
  public func push(_ route:RouteOption, animated:Bool = true) {
    navigationController?.pushViewController(route.controller, animated: animated)
  }
  
  public func pop(_ animated:Bool = true) {
    navigationController?.popViewController(animated: animated)
  }
  
  public func pop(_ to:RouteOption, animated:Bool = true) {
    navigationController?.popToViewController(to.controller, animated: animated)
  }
  
}
