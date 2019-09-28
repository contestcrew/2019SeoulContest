//
//  ExtensionCGFloat.swift
//  FirstCitizen
//
//  Created by Fury on 23/09/2019.
//  Copyright © 2019 Kira. All rights reserved.
//

import UIKit

extension CGFloat {
  func dynamic(_ multipliedBy: CGFloat) -> CGFloat {
    
    var resultMargin: CGFloat = 0
    let bounds = UIScreen.main.bounds
    let height = bounds.size.height
    
    switch height {
    case 480.0: //Iphone 3,4S => 3.5 inch
      resultMargin = self * 0.7
      break
    case 568.0: //iphone 5, SE => 4 inch
      resultMargin = self * 0.8
      break
    case 667.0: //iphone 6, 6s, 7, 8 => 4.7 inch
      resultMargin = self * 0.92
      break
    case 736.0: //iphone 6s+ 6+, 7+, 8+ => 5.5 inch
      resultMargin = self * 0.95
      break
    case 812.0: //iphone X, XS => 5.8 inch
      resultMargin = self
      break
    case 896.0: //iphone XR => 6.1 inch  // iphone XS MAX => 6.5 inch
      resultMargin = self * 1.15
      break
    default:
      print("not an iPhone")
      break
    }
    
    return resultMargin * multipliedBy
  }
}
