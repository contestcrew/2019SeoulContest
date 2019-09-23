//
//  ExtensionFont.swift
//  FirstCitizen
//
//  Created by Lee on 20/08/2019.
//  Copyright © 2019 Kira. All rights reserved.
//

import UIKit

extension UILabel {
  func dynamicFont(fontSize size: CGFloat, weight: UIFont.Weight) {
    let currentFontName = self.font.fontName
    var calculatedFont: UIFont?
    let bounds = UIScreen.main.bounds
    let height = bounds.size.height
    
    switch height {
    case 480.0: //Iphone 3,4S => 3.5 inch
      calculatedFont = UIFont(name: currentFontName, size: size * 0.7)
      resizeFont(calculatedFont: calculatedFont, weight: weight)
      break
    case 568.0: //iphone 5, SE => 4 inch
      calculatedFont = UIFont(name: currentFontName, size: size * 0.8)
      resizeFont(calculatedFont: calculatedFont, weight: weight)
      break
    case 667.0: //iphone 6, 6s, 7, 8 => 4.7 inch
      calculatedFont = UIFont(name: currentFontName, size: size * 0.92)
      resizeFont(calculatedFont: calculatedFont, weight: weight)
      break
    case 736.0: //iphone 6s+ 6+, 7+, 8+ => 5.5 inch
      calculatedFont = UIFont(name: currentFontName, size: size * 0.95)
     resizeFont(calculatedFont: calculatedFont, weight: weight)
      break
    case 812.0: //iphone X, XS => 5.8 inch
      calculatedFont = UIFont(name: currentFontName, size: size)
      resizeFont(calculatedFont: calculatedFont, weight: weight)
      break
    case 896.0: //iphone XR => 6.1 inch  // iphone XS MAX => 6.5 inch
      calculatedFont = UIFont(name: currentFontName, size: size * 1.15)
      resizeFont(calculatedFont: calculatedFont, weight: weight)
      break
    default:
      print("not an iPhone")
      break
    }
  }
  
  private func resizeFont(calculatedFont: UIFont?, weight: UIFont.Weight) {
    self.font = calculatedFont
    self.font = UIFont.systemFont(ofSize: calculatedFont!.pointSize, weight: weight)
  }
  
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
