//
//  ExtensionUIImage.swift
//  FirstCitizen
//
//  Created by hyeoktae kwon on 2019/09/18.
//  Copyright © 2019 Kira. All rights reserved.
//

import Foundation

extension UIImage {
  // 아직 사용할 예정 아님
  func dynamicImage(completion: (UIImage?) -> ()) {
    
    var resizeImage: UIImage?
    let bounds = UIScreen.main.bounds
    let height = bounds.size.height
    
    switch height {
    case 480.0: //Iphone 3,4S => 3.5 inch
      resizeImage = resizeImageByScale(scale: 0.2)
      completion(resizeImage)
      break
    case 568.0: //iphone 5, SE => 4 inch
      resizeImage = resizeImageByScale(scale: 0.3)
      completion(resizeImage)
      break
    case 667.0: //iphone 6, 6s, 7, 8 => 4.7 inch
      resizeImage = resizeImageByScale(scale: 0.33)
      completion(resizeImage)
      break
    case 736.0: //iphone 6s+ 6+, 7+, 8+ => 5.5 inch
      resizeImage = resizeImageByScale(scale: 0.36)
      completion(resizeImage)
      break
    case 812.0: //iphone X, XS => 5.8 inch
      resizeImage = resizeImageByScale(scale: 0.4)
      completion(resizeImage)
      break
    case 896.0: //iphone XR => 6.1 inch  // iphone XS MAX => 6.5 inch
      resizeImage = resizeImageByScale(scale: 0.47)
      completion(resizeImage)
      break
    default:
      print("not an iPhone")
      break
    }
  }
  
  private func resizeImageByScale(scale: CGFloat) -> UIImage? {
    let transform = CGAffineTransform(scaleX: scale, y: scale)
    let size = self.size.applying(transform)
    
    UIGraphicsBeginImageContext(size)
    self.draw(in: CGRect(origin: .zero, size: size))
    let resultImg = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    
    return resultImg
  }
  
  
  func resize(scale: CGFloat, completion: (UIImage?) -> ()) {
    let transform = CGAffineTransform(scaleX: scale, y: scale)
    let size = self.size.applying(transform)
    
    UIGraphicsBeginImageContext(size)
    self.draw(in: CGRect(origin: .zero, size: size))
    let resultImg = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    
    completion(resultImg)
  }
}
