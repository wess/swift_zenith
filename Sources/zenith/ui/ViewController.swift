/**
 *  ViewController.swift
 *  Zenith
 *
 *  Created by Wess Cope (me@wess.io) on 09/05/19
 *  Copyright 2019 Wess Cope
 */

import Foundation
import UIKit

/**
 ViewController for Zenith framework that simplifies the separation of Controller and view logic by
 instructing the view controller subclass what component it will use for rendering. All UIViewController methods
 are called just the same as before, like: `viewDidLoad`, `viewWillAppear`, `viewDidAppear`, `viewWillDisappear`, and `viewDidDisappear`
 along with corrisponding view component methods.
 
 ```swift
 class MyViewController : ViewController<MyViewComponent> {
 override func viewDidLoad() {
 super.viewDidLoad()
 // Do any additional setup after loading the component like normal.
 }
 }
 
 ```
 */
open class ViewController<C : ViewComponent>: UIViewController, UINavigationBarDelegate {
  
  /// View component the controller will use to manage view and present views.
  public let component:C
  
  private var _viewLoaded = false
  
  /**
   Required init that instantiates the view controller and creates an instance
   of the view component.
   */
  public required init() {
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
  
  /**
   Action for the default back navigation bar item.
   
   - parameter sender: The caller or object that called action.
   */
  @objc public func backAction(_ sender:Any?) {
    pop()
  }
}

extension ViewController /* navigation */ {
  /**
   Pushes to the provided route open.
   
   - parameter route: route option to move to.
   - parameter animated: Indicates if the action should be animated.
   */
  public func push(_ route:RouteOption, animated:Bool = true) {
    navigationController?.pushViewController(route.controller, animated: animated)
  }
  
  /**
   Pops current view controller and moves back to previous.
   
   - parameter animated: Indicates if the action should be animated.
   */
  public func pop(_ animated:Bool = true) {
    navigationController?.popViewController(animated: animated)
  }
  
  /**
   Pops current view controller back to specific route.
   
   - parameter route: route option to move to.
   - parameter animated: Indicates if the action should be animated.
   */
  public func pop(_ to:RouteOption, animated:Bool = true) {
    navigationController?.popToViewController(to.controller, animated: animated)
  }
  
}
