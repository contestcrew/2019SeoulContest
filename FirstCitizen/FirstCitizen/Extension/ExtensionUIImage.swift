//
//  ExtensionUIImage.swift
//  FirstCitizen
//
//  Created by hyeoktae kwon on 2019/09/18.
//  Copyright © 2019 Kira. All rights reserved.
//

import Foundation

extension UIImage {
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
