//
//  AlertController.swift
//  FirstCitizen
//
//  Created by Fury on 23/09/2019.
//  Copyright © 2019 Kira. All rights reserved.
//

import UIKit

extension UIAlertController {
  
  static func getCategoryInRequest(list: [String], alert: UIAlertAction) -> Int {
    for (idx, text) in list.enumerated() {
      if text == alert.title! {
        return idx + 1
      }
    }
    return 1
  }
  class func restroomShow(title: String, message: String, requsetID: Int, from controller: UIViewController) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "돕기", style: .default, handler: { _ in
      NetworkService.restroomReport(requestID: requsetID, completion: { result in
        switch result {
        case true:
          controller.dismiss(animated: true, completion: nil)
        case false:
          print(Error.self)
        }
      })
      
    }))
    alert.addAction(UIAlertAction(title: "취소", style: .cancel, handler: { _ in
      controller.dismiss(animated: true, completion: nil)
    }))
    controller.show(alert, sender: nil)
  }
  
  class func addDetailAddress(title: String, message: String, from controller: UIViewController, completion: @escaping (String) -> ()) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    
    alert.addTextField()
    alert.addAction(UIAlertAction(title: "입력", style: .default, handler: { (_) in
      if alert.textFields?.first?.text != nil{
          completion((alert.textFields?.first?.text)!)
      }
    }))
    alert.addAction(UIAlertAction(title: "취소", style: .cancel))
    controller.present(alert, animated: true)
  }
  
  // 미안 분기처리하기 귀찮아서 함수를 그냥 둘로 놔눳어 ㅠㅡㅠ
  // 맵에서 접근할때
  class func registerShowMap(categoryList: [String], title: String, message: String, from controller: UIViewController) {
    
    
    let alert = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
    
    categoryList.forEach {
      if $0 == "똥휴지" {
        alert.addAction(UIAlertAction(title: $0, style: .default, handler: { (alert) in
          
          let restroomRegisterVC = RestroomCreateViewController()
          restroomRegisterVC.fromMap = true
          restroomRegisterVC.category = getCategoryInRequest(list: categoryList, alert: alert)
          restroomRegisterVC.root = .map
          
          let vc = UINavigationController(rootViewController: restroomRegisterVC)
          
          controller.present(vc, animated: true, completion: nil)
        }))
      } else {
        alert.addAction(UIAlertAction(title: $0, style: .default, handler: { (alert) in
          
          let requestCreateVC = RequestCreateViewController()
          requestCreateVC.fromMap = true
          requestCreateVC.category = getCategoryInRequest(list: categoryList, alert: alert)
          requestCreateVC.root = .map
          
          let vc = UINavigationController(rootViewController: requestCreateVC)
          
          controller.present(vc, animated: true, completion: nil)
        }))
      }
    }
    alert.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))
    controller.show(alert, sender: nil)
  }
  
  // 셋팅에서 접근할떄
  class func registerShowSetting(categoryList: [String], title: String, message: String, from controller: UIViewController) {
    
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    
    categoryList.forEach {
      if $0 == "똥휴지" {
        alert.addAction(UIAlertAction(title: $0, style: .default, handler: { (alert) in
          
          let restroomRegisterVC = RestroomCreateViewController()
          restroomRegisterVC.fromMap = false
          restroomRegisterVC.category = getCategoryInRequest(list: categoryList, alert: alert)
          restroomRegisterVC.root = .setting
          controller.navigationController?.pushViewController(restroomRegisterVC, animated: true)
        }))
      } else {
        alert.addAction(UIAlertAction(title: $0, style: .default, handler: { (alert) in
          
          let requestCreateVC = RequestCreateViewController()
          requestCreateVC.fromMap = false
          requestCreateVC.category = getCategoryInRequest(list: categoryList, alert: alert)
          requestCreateVC.root = .setting
          controller.navigationController?.pushViewController(requestCreateVC, animated: true)
        }))
      }
    }
    alert.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))
    controller.present(alert, animated: true)
  }
}
