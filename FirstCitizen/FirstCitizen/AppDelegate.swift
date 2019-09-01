//
//  AppDelegate.swift
//  FirstCitizen
//
//  Created by Lee on 20/08/2019.
//  Copyright © 2019 Kira. All rights reserved.
//

import UIKit
import NaverThirdPartyLogin

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    /* [네아로] */
    let naverInstance = NaverThirdPartyLoginConnection.getSharedInstance()
    // 네이버 앱으로 인증하는 방식을 활성화
    naverInstance?.isNaverAppOauthEnable = true
    
    // SafariViewController에서 인증하는 방식을 활성화
    naverInstance?.isInAppOauthEnable = true
    
    // 인증 화면을 iPhone의 세로 모드에서만 사용하기
    naverInstance?.isOnlyPortraitSupportedInIphone()
    
    // 네이버 아이디로 로그인하기 설정
    // 애플리케이션을 등록할 때 입력한 URL Scheme
    naverInstance?.serviceUrlScheme = kServiceAppUrlScheme
    // 애플리케이션 등록 후 발급받은 클라이언트 아이디
    naverInstance?.consumerKey = kConsumerKey
    // 애플리케이션 등록 후 발급받은 클라이언트 시크릿
    naverInstance?.consumerSecret = kConsumerSecret
    // 애플리케이션 이름
    naverInstance?.appName = kServiceAppName
    
    window = UIWindow(frame: UIScreen.main.bounds)
    
    window?.rootViewController = LoginViewController()
    window?.makeKeyAndVisible()
    
    return true
  }
  
  func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
    if KOSession.isKakaoAccountLoginCallback(url.absoluteURL) {
      return KOSession.handleOpen(url)
    }
    
    NaverThirdPartyLoginConnection.getSharedInstance()?.application(app, open: url, options: options)
    return true
  }
}

