//
//  AppDelegate.swift
//  FirstCitizen
//
//  Created by Lee on 20/08/2019.
//  Copyright © 2019 Kira. All rights reserved.
//

import UIKit
import MapKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var window: UIWindow?
  
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    
    runApp()
    
    return true
  }
  
  func runApp() {
    let vc = SplashViewController()
    
    window = UIWindow(frame: UIScreen.main.bounds)
    window?.rootViewController = vc
    window?.makeKeyAndVisible()
  }
  
  func applicationDidBecomeActive(_ application: UIApplication) {
    runApp()
  }
  
}
