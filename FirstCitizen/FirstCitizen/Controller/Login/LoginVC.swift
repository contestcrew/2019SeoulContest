//
//  LoginVC.swift
//  FirstCitizen
//
//  Created by Lee on 25/09/2019.
//  Copyright © 2019 Kira. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {
  
  private let emailView = TextAddView()
  private let passwordView = TextAddView()
  private let loginButton = UIButton()
  private let signupButton = UIButton()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    navigationSet()
    configure()
    autoLayout()
  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    super.touchesBegan(touches, with: event)
    
    view.endEditing(true)
  }
  
  private func navigationSet() {
    navigationItem.title = "로그인"
    navigationController?.navigationBar.shadowImage = UIImage()
    navigationController?.navigationBar.barTintColor = .white
    
    let backButton = UIBarButtonItem(image: UIImage(named: "navi-arrow-24x24"), style: .done, target: self, action: #selector(back))
    navigationItem.leftBarButtonItem = backButton
  }
  
  @objc func back() {
//    presentingViewController?.dismiss(animated: true)
    self.dismiss(animated: true)
  }
  
  private func configure() {
    view.backgroundColor = .white
    
    emailView.title.text = "이메일"
    emailView.textField.becomeFirstResponder()
    emailView.textField.keyboardType = .emailAddress
    emailView.textField.delegate = self
    view.addSubview(emailView)
    
    passwordView.title.text = "비밀번호"
    passwordView.textField.isSecureTextEntry = true
    passwordView.textField.delegate = self
    view.addSubview(passwordView)
    
    loginButton.setTitle("로그인", for: .normal)
    loginButton.setTitleColor(.white, for: .normal)
    loginButton.titleLabel?.upsFontHeavy(ofSize: 20)
    loginButton.layer.cornerRadius = 8
    loginButton.backgroundColor = .blue
    loginButton.addTarget(self, action: #selector(loginAction), for: .touchUpInside)
    view.addSubview(loginButton)
    
    signupButton.setTitle("회원가입", for: .normal)
    signupButton.setTitleColor(.darkGray, for: .normal)
    signupButton.titleLabel?.upsFontBold(ofSize: 17)
    signupButton.addTarget(self, action: #selector(signupAction), for: .touchUpInside)
    view.addSubview(signupButton)
  }
  
  private func alertAction(tilte: String?, message: String?) {
    let alert = UIAlertController(title: tilte, message: message, preferredStyle: .alert)
    let cancel = UIAlertAction(title: "닫기", style: .cancel) { (action) in
      
    }
    alert.addAction(cancel)
    present(alert, animated: true)
  }
  
  @objc private func loginAction() {
    guard
      let email = emailView.textField.text,
      let password = passwordView.textField.text
      else { return }
    
    guard !email.isEmpty else {
      emailView.textField.becomeFirstResponder()
      return
    }
    
    guard !password.isEmpty else {
      passwordView.textField.becomeFirstResponder()
      return
    }
    
    emailView.textField.resignFirstResponder()
    passwordView.textField.resignFirstResponder()
    
    let url = URL(string: "http://eb-seoulcontest-deploy-master.ap-northeast-2.elasticbeanstalk.com/account/get_token/")!
    
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    
    let user = [
      "username": email,
      "password": password
    ]
    
    let temp = try! JSONEncoder().encode(user)
    
    URLSession.shared.uploadTask(with: request, from: temp) { [weak self] (data, response, error) in
      
      guard let `self` = self else { return }
      
      if let error = error {
        fatalError(error.localizedDescription)
        
      } else {
        guard let response = response as? HTTPURLResponse else { return }
        
        if (200..<300) ~= response.statusCode {
          // 성공시
          DispatchQueue.main.async {
            guard let data = data,
              let jsonObject = try? JSONSerialization.jsonObject(with: data) as? [String: Any]
              else { return print("No Data") }
            
            guard let token = jsonObject["token"] as? String,
                  let userID = jsonObject["user_id"] as? Int
              else { return print("Parsing Error") }
            
            UserDefaults.standard.set("Token " + token, forKey: "Token")
            UserDefaults.standard.set(userID, forKey: "userID")
            print("토큰 :", token)
            UserDefaults.standard.set("Token " + token, forKey: "Token")
            guard let ud = UserDefaults.standard.object(forKey: "Token") else { return }
            print("UserDefaults :", ud)
            
            self.getUserInfo()
//            self.navigationController?.popViewController(animated: true)
          }
          
        } else if (400..<500) ~= response.statusCode {
          // 정보가 틀렷을시
          DispatchQueue.main.async {
            self.alertAction(tilte: "정보가 올바르지 않습니다", message: nil)
          }
          
        } else {
          // 그 외
          DispatchQueue.main.async {
            self.alertAction(tilte: "잠시 후 다시 시도해 주세요", message: nil)
          }
        }
      }
    }.resume()
    
    
  }
  
  private func getUserInfo() {
    NetworkService.getUserInfo { result in
      switch result {
      case .success(let data):
        guard let presentedVC = self.presentingViewController as? MainTabBarController else { return }
        guard let naviVC = presentedVC.viewControllers?[3] as? UINavigationController else { return }
        guard let vc = naviVC.viewControllers[0] as? SettingViewController else { return }
        
        let userShared = UserInfoManager.shared
        userShared.userInfo = data

        DispatchQueue.main.async {
          vc.isSign = false
          vc.tableView.reloadData()
          self.dismiss(animated: true)
        }
      case .failure(let err):
        print(err.localizedDescription)
      }
    }
  }
  
  @objc private func signupAction() {
    let vc = SignupVC()
    
    navigationController?.pushViewController(vc, animated: true)
  }
  
  private struct Standard {
    static let space: CGFloat = 8
    static let xSpace: CGFloat = 32
    static let ySpace: CGFloat = 24
  }
  
  private func autoLayout() {
    let guide = view.safeAreaLayoutGuide
    
    emailView.translatesAutoresizingMaskIntoConstraints = false
    emailView.topAnchor.constraint(equalTo: guide.topAnchor, constant: Standard.ySpace).isActive = true
    emailView.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: Standard.xSpace).isActive = true
    emailView.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -Standard.xSpace).isActive = true
    
    passwordView.translatesAutoresizingMaskIntoConstraints = false
    passwordView.topAnchor.constraint(equalTo: emailView.bottomAnchor, constant: Standard.ySpace).isActive = true
    passwordView.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: Standard.xSpace).isActive = true
    passwordView.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -Standard.xSpace).isActive = true
    
    loginButton.translatesAutoresizingMaskIntoConstraints = false
    loginButton.centerXAnchor.constraint(equalTo: guide.centerXAnchor).isActive = true
    loginButton.topAnchor.constraint(equalTo: passwordView.bottomAnchor, constant: Standard.ySpace).isActive = true
    loginButton.widthAnchor.constraint(equalToConstant: 240).isActive = true
    loginButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
    
    signupButton.translatesAutoresizingMaskIntoConstraints = false
    signupButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: Standard.ySpace).isActive = true
    signupButton.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -16).isActive = true
  }
}

extension LoginVC: UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    switch textField {
    case emailView.textField:
      passwordView.textField.becomeFirstResponder()
      
    default:
      passwordView.textField.resignFirstResponder()
    }
    
    return false
  }
}
