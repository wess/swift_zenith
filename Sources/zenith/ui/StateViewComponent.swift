/**
 *  StateViewComponent.swift
 *  Zenith
 * 
 *  Created by Wess Cope (me@wess.io) on 09/05/19
 *  Copyright 2019 Wess Cope
 */

 import UIKit
 
public typealias ComponentState = Any

public class StateViewComponent<T:ComponentState> : ViewComponent {
  public typealias StateHandler = (ComponentState) -> Void
  
  public var state:T! {
    didSet {
      self.onChange?(state)
    }
  }
  
  public private(set) var onChange:(StateHandler)? = nil
  
}
