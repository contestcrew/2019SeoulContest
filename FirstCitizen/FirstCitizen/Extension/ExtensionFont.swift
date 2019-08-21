//
//  ExtensionFont.swift
//  FirstCitizen
//
//  Created by Lee on 20/08/2019.
//  Copyright © 2019 Kira. All rights reserved.
//

import UIKit

extension UILabel {
  func upsFont(ofSize: CGFloat) {
    self.font = UIFont.systemFont(ofSize: ofSize)
  }
  
  func upsFontBold(ofSize: CGFloat) {
    self.font = UIFont.systemFont(ofSize: ofSize, weight: .bold)
  }
  
  func upsFontHeavy(ofSize: CGFloat) {
    self.font = UIFont.systemFont(ofSize: ofSize, weight: .heavy)
  }
}
