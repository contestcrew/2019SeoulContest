//
//  SignupVC.swift
//  FirstCitizen
//
//  Created by Lee on 25/09/2019.
//  Copyright © 2019 Kira. All rights reserved.
//

import UIKit

class SignupVC: UIViewController {
  
  private let emailView = TextAddView()
  private let passwordView = TextAddView()
  private let checkView = TextAddView()
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
    navigationItem.title = "회원가입"
    navigationController?.navigationBar.shadowImage = UIImage()
    navigationController?.navigationBar.barTintColor = .white
    
    let backButton = UIBarButtonItem(image: UIImage(named: "navi-arrow-24x24"), style: .done, target: self, action: #selector(back))
    navigationItem.leftBarButtonItem = backButton
  }
  
  @objc func back() {
    navigationController?.popViewController(animated: true)
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
    
    checkView.title.text = "비밀번호 재입력"
    checkView.textField.isSecureTextEntry = true
    checkView.textField.delegate = self
    view.addSubview(checkView)
    
    signupButton.setTitle("회원가입", for: .normal)
    signupButton.setTitleColor(.white, for: .normal)
    signupButton.titleLabel?.upsFontHeavy(ofSize: 20)
    signupButton.layer.cornerRadius = 8
    signupButton.backgroundColor = .blue
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
  
  private func successAlert(tilte: String?, message: String?) {
    let alert = UIAlertController(title: tilte, message: message, preferredStyle: .alert)
    let cancel = UIAlertAction(title: "닫기", style: .cancel) { [weak self] (action) in
      guard let `self` = self else { return }
      self.navigationController?.popViewController(animated: true)
    }
    alert.addAction(cancel)
    present(alert, animated: true)
  }
  
  @objc private func signupAction() {
    guard
      let email = emailView.textField.text,
      let password1 = passwordView.textField.text,
      let password2 = checkView.textField.text
      else { return }
    
    guard !email.isEmpty else {
      emailView.textField.becomeFirstResponder()
      return
    }
    
    guard !password1.isEmpty else {
      passwordView.textField.becomeFirstResponder()
      return
    }
    
    guard !password2.isEmpty else {
      checkView.textField.becomeFirstResponder()
      return
    }
    
    guard password1 == password2 else {
      alertAction(tilte: "비밀번호가 틀립니다", message: nil)
      return
    }
    
    let url = URL(string: "http://eb-seoulcontest-deploy-master.ap-northeast-2.elasticbeanstalk.com/account/")!
    
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    
    let user = [
      "username": email,
      "password": password1,
      "device_token": "temp"
    ]
    
    let temp = try! JSONEncoder().encode(user)
    
    URLSession.shared.uploadTask(with: request, from: temp) { [weak self] (data, response, error) in
      
      guard let `self` = self else { return }
      
      if let error = error {
        fatalError(error.localizedDescription)
        
      } else {
        guard let response = response as? HTTPURLResponse else { return }
        
        if (200..<300) ~= response.statusCode {
          DispatchQueue.main.async {
            self.successAlert(tilte: "회원가입 성공", message: nil)
          }
        } else if (400..<500) ~= response.statusCode {
          DispatchQueue.main.async {
            self.alertAction(tilte: "이메일 중복", message: nil)
          }
        } else {
          DispatchQueue.main.async {
            self.alertAction(tilte: "잠시 후 다시 시도해 주세요", message: nil)
          }
        }
      }
    }.resume()
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
    
    checkView.translatesAutoresizingMaskIntoConstraints = false
    checkView.topAnchor.constraint(equalTo: passwordView.bottomAnchor, constant: Standard.ySpace).isActive = true
    checkView.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: Standard.xSpace).isActive = true
    checkView.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -Standard.xSpace).isActive = true
    
    signupButton.translatesAutoresizingMaskIntoConstraints = false
    signupButton.centerXAnchor.constraint(equalTo: guide.centerXAnchor).isActive = true
    signupButton.topAnchor.constraint(equalTo: checkView.bottomAnchor, constant: Standard.ySpace).isActive = true
    signupButton.widthAnchor.constraint(equalToConstant: 240).isActive = true
    signupButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
  }
}

extension SignupVC: UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    switch textField {
    case emailView.textField:
      passwordView.textField.becomeFirstResponder()
      
    case passwordView.textField:
      checkView.textField.becomeFirstResponder()
      
    default:
      checkView.textField.resignFirstResponder()
    }
    
    return false
  }
}
