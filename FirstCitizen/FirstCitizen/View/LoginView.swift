//
//  LoginView.swift
//  FirstCitizen
//
//  Created by Fury on 26/08/2019.
//  Copyright © 2019 Kira. All rights reserved.
//

import UIKit
import SnapKit

protocol LoginViewDelegate: class {
  func touchUpLoginButton()
  func touchUpNaverLoginButton()
  func touchUpKakaoLoginButton()
  func touchUpSignUpButton()
}

class LoginView: UIView {
  
  weak var delegate: LoginViewDelegate?
  
  private let logoImage = UIImageView()
  private let emailTextField = UITextField()
  private let validEmailLabel = UILabel()
  private let passwordTextField = UITextField()
  private let validPasswordLabel = UILabel()
  
  private let forgetInfoButton = UIButton()
  private let signInButton = UIButton()
  private let naverSignInButton = UIButton()
  private let kakaoSignInButton = KOLoginButton()
  private var signUpStackView = UIStackView()
  private let signUpExplainLabel = UILabel()
  private let signUpButton = UIButton()
  
  private let copyrightLabel = UILabel()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    attribute()
    layout()
  }
  
  private func attribute() {
    logoImage.image = #imageLiteral(resourceName: "Login_Top_Logo")
    logoImage.contentMode = .scaleAspectFit
    
    emailTextField.borderStyle = .roundedRect
    emailTextField.placeholder = "이메일 주소"
    emailTextField.keyboardType = .emailAddress
    emailTextField.delegate = self
    
    passwordTextField.borderStyle = .roundedRect
    passwordTextField.placeholder = "비밀번호"
    passwordTextField.returnKeyType = .done
    passwordTextField.isSecureTextEntry = true
    passwordTextField.delegate = self
    
    forgetInfoButton.setTitle("비밀번호를 잊으셨나요?", for: .normal)
    forgetInfoButton.setTitleColor(#colorLiteral(red: 0.7042449117, green: 0.700060606, blue: 0.707462728, alpha: 1), for: .normal)
    forgetInfoButton.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
    
    signInButton.setTitle("로그인", for: .normal)
    signInButton.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
    signInButton.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
    signInButton.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    signInButton.addTarget(self, action: #selector(touchUpLoginButton), for: .touchUpInside)
    
    naverSignInButton.setImage(#imageLiteral(resourceName: "Login_Naver_Green"), for: .normal)
    naverSignInButton.contentMode = .scaleAspectFit
    naverSignInButton.addTarget(self, action: #selector(touchUpNaverSignInButton), for: .touchUpInside)
    
    kakaoSignInButton.setImage(#imageLiteral(resourceName: "Login_Naver_Green"), for: .normal)
    kakaoSignInButton.contentMode = .scaleAspectFit
    kakaoSignInButton.addTarget(self, action: #selector(touchUpKakaoSignInButton), for: .touchUpInside)
    
    signUpStackView = UIStackView(arrangedSubviews: [signUpExplainLabel, signUpButton])
    signUpStackView.alignment = .fill
    signUpStackView.spacing = 5

    signUpExplainLabel.text = "회원이 아니신가요?"
    signUpExplainLabel.textColor = #colorLiteral(red: 0.7042449117, green: 0.700060606, blue: 0.707462728, alpha: 1)
    signUpExplainLabel.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
    
    signUpButton.setTitle("회원가입", for: .normal)
    signUpButton.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
    signUpButton.setTitleShadowColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
    signUpButton.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
    signUpButton.addTarget(self, action: #selector(touchUpSignUpButton), for: .touchUpInside)
    
    copyrightLabel.text = "© 2019 ContestCrew All rights reserved."
    copyrightLabel.textColor = #colorLiteral(red: 0.7042449117, green: 0.700060606, blue: 0.707462728, alpha: 1)
    copyrightLabel.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
  }
  
  @objc private func touchUpLoginButton() {
    delegate?.touchUpLoginButton()
  }
  
  @objc private func touchUpNaverSignInButton() {
    delegate?.touchUpNaverLoginButton()
  }
  
  @objc private func touchUpKakaoSignInButton() {
    delegate?.touchUpKakaoLoginButton()
  }
  
  @objc private func touchUpSignUpButton() {
    delegate?.touchUpSignUpButton()
  }
  
  
  private func layout() {
    self.addSubview(logoImage)
    self.addSubview(emailTextField)
    self.addSubview(validEmailLabel)
    self.addSubview(passwordTextField)
    self.addSubview(validPasswordLabel)
    self.addSubview(forgetInfoButton)
    self.addSubview(signInButton)
    self.addSubview(naverSignInButton)
    self.addSubview(kakaoSignInButton)
    self.addSubview(signUpStackView)
    self.addSubview(copyrightLabel)
    
    logoImage.snp.makeConstraints {
      $0.top.equalToSuperview().offset(80)
      $0.leading.equalToSuperview().offset(30)
      $0.trailing.equalToSuperview().offset(-30)
      $0.height.equalTo(100)
    }
    
    emailTextField.snp.makeConstraints {
      $0.top.equalTo(logoImage.snp.bottom).offset(50)
      $0.leading.equalToSuperview().offset(30)
      $0.trailing.equalToSuperview().offset(-30)
      $0.height.equalTo(50)
    }
    
    passwordTextField.snp.makeConstraints {
      $0.top.equalTo(emailTextField.snp.bottom).offset(20)
      $0.leading.equalToSuperview().offset(30)
      $0.trailing.equalToSuperview().offset(-30)
      $0.height.equalTo(50)
    }
    
    forgetInfoButton.snp.makeConstraints {
      $0.top.equalTo(passwordTextField.snp.bottom).offset(10)
      $0.trailing.equalToSuperview().offset(-30)
      $0.height.equalTo(50)
    }
    
    signInButton.snp.makeConstraints {
      $0.top.equalTo(forgetInfoButton.snp.bottom).offset(10)
      $0.leading.equalToSuperview().offset(30)
      $0.trailing.equalToSuperview().offset(-30)
      $0.height.equalTo(50)
    }
    
    naverSignInButton.snp.makeConstraints {
      $0.top.equalTo(signInButton.snp.bottom).offset(10)
      $0.leading.equalToSuperview().offset(30)
      $0.trailing.equalToSuperview().offset(-30)
      $0.height.equalTo(50)
    }
    
    kakaoSignInButton.snp.makeConstraints {
      $0.top.equalTo(naverSignInButton.snp.bottom).offset(10)
      $0.leading.equalToSuperview().offset(30)
      $0.trailing.equalToSuperview().offset(-30)
      $0.height.equalTo(50)
    }
    
    signUpStackView.snp.makeConstraints {
      $0.top.equalTo(kakaoSignInButton.snp.bottom).offset(10)
      $0.centerX.equalToSuperview()
    }
    
    copyrightLabel.snp.makeConstraints {
      $0.bottom.equalTo(safeAreaLayoutGuide.snp.bottom)
      $0.centerX.equalToSuperview()
    }
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension LoginView: UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    if textField == emailTextField {
      passwordTextField.becomeFirstResponder()
    } else {
      passwordTextField.resignFirstResponder()
    }
    return true
  }
}
