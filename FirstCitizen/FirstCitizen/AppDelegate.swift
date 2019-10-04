//
//  AppDelegate.swift
//  FirstCitizen
//
//  Created by Lee on 20/08/2019.
//  Copyright © 2019 Kira. All rights reserved.
//

import UIKit
//import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var window: UIWindow?
  let vc = SplashViewController()
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    
//    FirebaseApp.configure()
    
    runApp()
    
    // app DarkMode 대응
    if #available(iOS 13.0, *) {
      self.window?.overrideUserInterfaceStyle = .light
    }
    
    return true
  }
  
  func runApp() {
    
    window = UIWindow(frame: UIScreen.main.bounds)
    window?.rootViewController = vc
    window?.makeKeyAndVisible()
  }
  
}



