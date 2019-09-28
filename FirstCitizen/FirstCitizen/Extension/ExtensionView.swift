//
//  ExtensionView.swift
//  FirstCitizen
//
//  Created by Lee on 20/08/2019.
//  Copyright © 2019 Kira. All rights reserved.
//

import UIKit

extension UIView {
  func shadow() {
    self.layer.shadowRadius = 5.0
    self.layer.shadowOpacity = 0.3
    self.layer.shadowOffset = .zero
    self.layer.shadowColor = UIColor.darkGray.cgColor
  }
  
  func bindToKeyboard(){
    NotificationCenter.default.addObserver(self, selector: #selector(UIView.keyboardWillChange(_:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
  }
  
  @objc func keyboardWillChange(_ notification: NSNotification) {
    let duration = notification.userInfo![UIResponder.keyboardAnimationDurationUserInfoKey] as! Double
    let curve = notification.userInfo![UIResponder.keyboardAnimationCurveUserInfoKey] as! UInt
    let curFrame = (notification.userInfo![UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
    let targetFrame = (notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
    let deltaY = targetFrame.origin.y - curFrame.origin.y
    
    UIView.animateKeyframes(withDuration: duration, delay: 0.0, options: UIView.KeyframeAnimationOptions(rawValue: curve), animations: {
      self.frame.origin.y += deltaY
      
    },completion: {(true) in
      self.layoutIfNeeded()
    })
  }
}

