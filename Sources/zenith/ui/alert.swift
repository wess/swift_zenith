/**
 *  alert.swift
 *  foundation
 * 
 *  Created by Wess Cope (me@wess.io) on 09/05/18
 *  Copyright 2018 WessCope
 */

import Foundation
import UIKit

public func alert(_ title:String, description:String? = nil, callback:(() -> Void)? = nil) {
  guard let root = UIApplication.shared.delegate?.window??.rootViewController else {
    let message = "\(title)" + (description == nil ? "" : ": \(description!)")
    
    console.error("\(#function) - No root available")
    console.info(message)
    
    return
  }
  
  let alertController = UIAlertController(title: title, message: description, preferredStyle: .alert)
  
  root.present(alertController, animated: true, completion: callback)
}
