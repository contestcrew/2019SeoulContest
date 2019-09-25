//
//  AlertController.swift
//  FirstCitizen
//
//  Created by Fury on 23/09/2019.
//  Copyright © 2019 Kira. All rights reserved.
//

import UIKit

extension UIAlertController {
  class func restroomShow(title: String, message: String, from controller: UIViewController) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "돕기", style: .default, handler: { _ in
      controller.dismiss(animated: true, completion: nil)
    }))
    alert.addAction(UIAlertAction(title: "취소", style: .cancel, handler: { _ in
      controller.dismiss(animated: true, completion: nil)
    }))
    controller.show(alert, sender: nil)
  }
  
  class func registerShow(categoryList: [String], title: String, message: String, from controller: UIViewController) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
    
    categoryList.forEach {
      if $0 == "똥휴지" {
        alert.addAction(UIAlertAction(title: $0, style: .default, handler: { (_) in
          let restroomRegisterVC = RestroomCreateViewController()
          restroomRegisterVC.root = .map
          
          let vc = UINavigationController(rootViewController: restroomRegisterVC)
          
          controller.present(vc, animated: true, completion: nil)
        }))
      } else {
        alert.addAction(UIAlertAction(title: $0, style: .default, handler: { (_) in
          let requestCreateVC = RequestCreateViewController()
          requestCreateVC.root = .map
          
          let vc = UINavigationController(rootViewController: requestCreateVC)
          
          controller.present(vc, animated: true, completion: nil)
        }))
      }
    }
    alert.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))
    controller.show(alert, sender: nil)
  }
  
  class func registerShow2(categoryList: [String], title: String, message: String, from controller: UIViewController) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    
    categoryList.forEach {
      if $0 == "똥휴지" {
        alert.addAction(UIAlertAction(title: $0, style: .default, handler: { (_) in
          let restroomRegisterVC = RestroomCreateViewController()
          restroomRegisterVC.root = .setting
          controller.navigationController?.pushViewController(restroomRegisterVC, animated: true)
        }))
      } else {
        alert.addAction(UIAlertAction(title: $0, style: .default, handler: { (_) in
          let requestCreateVC = RequestCreateViewController()
          requestCreateVC.root = .setting
          controller.navigationController?.pushViewController(requestCreateVC, animated: true)
        }))
      }
    }
    alert.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))
    controller.present(alert, animated: true)
  }
}
