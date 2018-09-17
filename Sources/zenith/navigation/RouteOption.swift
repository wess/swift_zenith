/**
 *  RouteOption.swift
 *  navigation
 * 
 *  Created by Wess Cope (me@wess.io) on 09/05/18
 *  Copyright 2018 WessCope
 */

import Foundation
import UIKit

public protocol RouteOption {
  var controller:UIViewController { get }
}
