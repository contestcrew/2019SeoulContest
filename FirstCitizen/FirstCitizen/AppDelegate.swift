//
//  AppDelegate.swift
//  FirstCitizen
//
//  Created by Lee on 20/08/2019.
//  Copyright © 2019 Kira. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var window: UIWindow?
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    
    window = UIWindow(frame: UIScreen.main.bounds)
    
    window?.rootViewController = SplashViewController()
//    window?.rootViewController = UINavigationController(rootViewController: LoginVC())
    window?.makeKeyAndVisible()
    
//    NetworkService.report {
//      print($0)
//    }
    
    return true
  }
}

