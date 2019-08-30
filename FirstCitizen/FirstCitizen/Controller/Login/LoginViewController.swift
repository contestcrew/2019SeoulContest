//
//  LoginViewController.swift
//  FirstCitizen
//
//  Created by Fury on 26/08/2019.
//  Copyright © 2019 Kira. All rights reserved.
//

import UIKit
import SnapKit
import Alamofire
import NaverThirdPartyLogin

class LoginViewController: UIViewController {
  
  // MARK: - Properties
  // 네아로 인스턴스
  let loginInstance = NaverThirdPartyLoginConnection.getSharedInstance()
  
  private let loginView = LoginView()

  // MARK: - Lfie Cycles
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    
    layout()
    
    loginView.delegate = self
  }
  
  // MARK: - Methods
  private func layout() {
    self.view.addSubview(loginView)
    
    loginView.snp.makeConstraints {
      $0.top.leading.trailing.bottom.equalToSuperview()
    }
  }
}

// MARK: - Extension
//TODO: - 이미 존재하는 회원인지 처음 로그인하는 회원인지 구별하는 로직
extension LoginViewController: LoginViewDelegate {
  func touchUpSignUpButton() {
    let signupVC = SignupViewController()
    self.present(signupVC, animated: false, completion: nil)
  }
  
  func touchUpLoginButton() {
    let preparedVC = PreparedViewController()
    preparedVC.isSocialLogin = false
    self.present(preparedVC, animated: false, completion: nil)
  }
  
  func touchUpKakaoLoginButton() {
    guard let session = KOSession.shared() else { return }
    if session.isOpen() {
      session.close()
    }
    
    session.open { error in
      if error != nil || !session.isOpen() { return }
      KOSessionTask.userMeTask(completion: { (error, user) in
        guard let user = user,
          let email = user.account?.email else { return}
        
        //TODO: 최초 로그인 유무 확인 후 present 코드 작성(카카오)
      })
    }
  }
  
  func touchUpNaverLoginButton() {
    loginInstance?.delegate = self
    loginInstance?.requestThirdPartyLogin()
  }
  
  private func getNaverInfo() {
    guard let isValidAccessToken = loginInstance?.isValidAccessTokenExpireTimeNow() else { return }
    
    if !isValidAccessToken {
      return
    }
    print("hello2")
    guard let tokenType = loginInstance?.tokenType else { return }
    guard let accessToken = loginInstance?.accessToken else { return }
    let urlStr = "https://openapi.naver.com/v1/nid/me"
    let url = URL(string: urlStr)!
    
    let authorization = "\(tokenType) \(accessToken)"
    
    let req = Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: ["Authorization": authorization])
    
    req.responseJSON { response in
      guard let result = response.result.value as? [String: Any] else { return }
      guard let object = result["response"] as? [String: Any] else { return }
      guard let email = object["email"] as? String else { return }
      
      print(email)
    }
  }
}

extension LoginViewController: NaverThirdPartyLoginConnectionDelegate {
  // 로그인 버튼을 눌렀을 경우 열게 될 브라우저
  func oauth20ConnectionDidOpenInAppBrowser(forOAuth request: URLRequest!) {
    let naverSignInVC = NLoginThirdPartyOAuth20InAppBrowserViewController(request: request)!
    naverSignInVC.parentOrientation = UIInterfaceOrientation(rawValue: UIDevice.current.orientation.rawValue)!
    present(naverSignInVC, animated: false, completion: nil)
  }
  
  // 로그인에 성공했을 경우 호출
  func oauth20ConnectionDidFinishRequestACTokenWithAuthCode() {
    print("[Success] : Success Naver Login")
    getNaverInfo()
    //TODO: 최초 로그인 유무 확인 후 present 코드 작성(Naver)
  }
  
  // 접근 토큰 갱신
  func oauth20ConnectionDidFinishRequestACTokenWithRefreshToken() {
    
  }
  
  // 로그아웃 할 경우 호출(토큰 삭제)
  func oauth20ConnectionDidFinishDeleteToken() {
    loginInstance?.requestDeleteToken()
  }
  
  // 모든 Error
  func oauth20Connection(_ oauthConnection: NaverThirdPartyLoginConnection!, didFailWithError error: Error!) {
    print("[Error] :", error.localizedDescription)
  }
}
