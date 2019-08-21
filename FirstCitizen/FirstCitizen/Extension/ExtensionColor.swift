//
//  ExtensionColor.swift
//  FirstCitizen
//
//  Created by Lee on 20/08/2019.
//  Copyright © 2019 Kira. All rights reserved.
//

import UIKit

extension UIColor {
  class var random: UIColor {
    get {
      let nim: CGFloat = 0.3
      let max: CGFloat = 0.7
      
      let red = CGFloat.random(in: nim ... max)
      let green = CGFloat.random(in: nim ... max)
      let blue = CGFloat.random(in: nim ... max)
      
      return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
  }
  
  class var add: UIColor {
    get {
      return #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1)
    }
  }
  
  class var sub: UIColor {
    get {
      return #colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1)
    }
  }
  
  convenience init(hexString: String, alpha: CGFloat = 1.0) {
    let hexString: String = hexString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    let scanner = Scanner(string: hexString)
    
    if (hexString.hasPrefix("#")) {
      scanner.scanLocation = 1
    }
    
    var color: UInt32 = 0
    scanner.scanHexInt32(&color)
    let mask = 0x000000FF
    let r = Int(color >> 16) & mask
    let g = Int(color >> 8) & mask
    let b = Int(color) & mask
    let red   = CGFloat(r) / 255.0
    let green = CGFloat(g) / 255.0
    let blue  = CGFloat(b) / 255.0
    self.init(red:red, green:green, blue:blue, alpha:alpha)
  }
}
