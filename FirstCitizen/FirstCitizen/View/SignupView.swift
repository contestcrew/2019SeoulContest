//
//  SignupView.swift
//  FirstCitizen
//
//  Created by Fury on 27/08/2019.
//  Copyright © 2019 Kira. All rights reserved.
//

import UIKit
import SnapKit

protocol SignupViewDelegate: class {
  func touchUpBackButton()
  func touchUpSignUpButton()
}

class SignupView: UIView {
  
  weak var delegate: SignupViewDelegate?
  
  private let signupTitleLabel = UILabel()
  
  private let backButton = UIButton()
  
  private let emailLabel = UILabel()
  private let emailTextField = UITextField()
  private let emailDoubleCheckButton = UIButton()
  
  private let passwordLabel = UILabel()
  private let passwordTextField = UITextField()
  private let rePasswordTextField = UITextField()
  
  private let phoneNumberLabel = UILabel()
  private let phoneNumberTextField = UITextField()
  private let phoneNumberCheckButton = UIButton()
  
  private let certificationNumberTextField = UITextField()
  private let certificationButton = UIButton()
  
  private let signUpButton = UIButton()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    attribute()
    layout()
  }
  
  @objc private func touchUpBackButton() {
    delegate?.touchUpBackButton()
  }
  
  @objc private func touchUpSignUpButton() {
    delegate?.touchUpSignUpButton()
  }
  
  private func attribute() {
    signupTitleLabel.text = "회원가입"
    signupTitleLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    signupTitleLabel.textAlignment = .center
    signupTitleLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
    
    backButton.setImage(#imageLiteral(resourceName: "Back_Button"), for: .normal)
    backButton.contentMode = .scaleAspectFit
    backButton.addTarget(self, action: #selector(touchUpBackButton), for: .touchUpInside)
    
    emailLabel.text = "이메일"
    emailLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    emailLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
    
    emailTextField.placeholder = "이메일을 입력해주세요"
    emailTextField.backgroundColor = #colorLiteral(red: 0.8979362845, green: 0.8925986886, blue: 0.9020394683, alpha: 1)
    emailTextField.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 0)
    
    passwordLabel.text = "비밀번호"
    passwordLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    passwordLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
    
    passwordTextField.placeholder = "비밀번호를 입력해주세요"
    passwordTextField.backgroundColor = #colorLiteral(red: 0.8979362845, green: 0.8925986886, blue: 0.9020394683, alpha: 1)
    passwordTextField.isSecureTextEntry = true
    passwordTextField.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 0)
    
    rePasswordTextField.placeholder = "비밀번호를 한번더 입력해주세요e"
    rePasswordTextField.backgroundColor = #colorLiteral(red: 0.8979362845, green: 0.8925986886, blue: 0.9020394683, alpha: 1)
    rePasswordTextField.isSecureTextEntry = true
    rePasswordTextField.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 0)
    
    phoneNumberLabel.text = "휴대폰 인증"
    phoneNumberLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    phoneNumberLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
    
    phoneNumberTextField.placeholder = "휴대폰 번호를 입력해주세요"
    phoneNumberTextField.backgroundColor = #colorLiteral(red: 0.8979362845, green: 0.8925986886, blue: 0.9020394683, alpha: 1)
    phoneNumberTextField.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 0)
    
    phoneNumberCheckButton.setTitle("인증하기", for: .normal)
    phoneNumberCheckButton.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
    phoneNumberCheckButton.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
    phoneNumberCheckButton.backgroundColor = #colorLiteral(red: 0.9387614727, green: 0.2644762397, blue: 0.261760056, alpha: 1)
    
    certificationNumberTextField.placeholder = "인증 번호를 입력해주세요"
    certificationNumberTextField.backgroundColor = #colorLiteral(red: 0.8979362845, green: 0.8925986886, blue: 0.9020394683, alpha: 1)
    certificationNumberTextField.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 0)
    
    certificationButton.setTitle("확인", for: .normal)
    certificationButton.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
    certificationButton.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
    certificationButton.backgroundColor = #colorLiteral(red: 0.9387614727, green: 0.2644762397, blue: 0.261760056, alpha: 1)
    
    signUpButton.setTitle("회원가입", for: .normal)
    signUpButton.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
    signUpButton.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
    signUpButton.backgroundColor = #colorLiteral(red: 0.9387614727, green: 0.2644762397, blue: 0.261760056, alpha: 1)
    signUpButton.addTarget(self, action: #selector(touchUpSignUpButton), for: .touchUpInside)
  }
  
  private func layout() {
    self.addSubview(signupTitleLabel)
    self.addSubview(backButton)
    self.addSubview(emailLabel)
    self.addSubview(emailTextField)
    self.addSubview(passwordLabel)
    self.addSubview(passwordTextField)
    self.addSubview(rePasswordTextField)
    self.addSubview(phoneNumberLabel)
    self.addSubview(phoneNumberTextField)
    self.addSubview(phoneNumberCheckButton)
    self.addSubview(certificationNumberTextField)
    self.addSubview(certificationButton)
    self.addSubview(signUpButton)
    
    signupTitleLabel.snp.makeConstraints {
      $0.top.leading.trailing.equalToSuperview()
      $0.height.equalTo(50)
    }
    
    backButton.snp.makeConstraints {
      $0.top.equalToSuperview().offset(10)
      $0.leading.equalToSuperview().offset(10)
      $0.width.height.equalTo(30)
    }
    
    emailLabel.snp.makeConstraints {
      $0.top.equalTo(signupTitleLabel.snp.bottom).offset(30)
      $0.leading.equalToSuperview().offset(20)
    }
    
    emailTextField.snp.makeConstraints {
      $0.top.equalTo(emailLabel.snp.bottom).offset(10)
      $0.leading.equalToSuperview().offset(20)
      $0.trailing.equalToSuperview().offset(-20)
      $0.height.equalTo(50)
    }
    
    passwordLabel.snp.makeConstraints {
      $0.top.equalTo(emailTextField.snp.bottom).offset(30)
      $0.leading.equalToSuperview().offset(20)
    }
    
    passwordTextField.snp.makeConstraints {
      $0.top.equalTo(passwordLabel.snp.bottom).offset(10)
      $0.leading.equalToSuperview().offset(20)
      $0.trailing.equalToSuperview().offset(-20)
      $0.height.equalTo(50)
    }
    
    rePasswordTextField.snp.makeConstraints {
      $0.top.equalTo(passwordTextField.snp.bottom).offset(20)
      $0.leading.equalToSuperview().offset(20)
      $0.trailing.equalToSuperview().offset(-20)
      $0.height.equalTo(50)
    }
    
    phoneNumberLabel.snp.makeConstraints {
      $0.top.equalTo(rePasswordTextField.snp.bottom).offset(30)
      $0.leading.equalToSuperview().offset(20)
    }
    
    phoneNumberTextField.snp.makeConstraints {
      $0.top.equalTo(phoneNumberLabel.snp.bottom).offset(10)
      $0.leading.equalToSuperview().offset(20)
      $0.height.equalTo(50)
    }
    
    phoneNumberCheckButton.snp.makeConstraints {
      $0.top.equalTo(phoneNumberLabel.snp.bottom).offset(10)
      $0.leading.equalTo(phoneNumberTextField.snp.trailing)
      $0.trailing.equalToSuperview().offset(-20)
      $0.height.equalTo(50)
      $0.width.equalTo(phoneNumberTextField.snp.width).multipliedBy(0.25)
    }
    
    certificationNumberTextField.snp.makeConstraints {
      $0.top.equalTo(phoneNumberTextField.snp.bottom).offset(10)
      $0.leading.equalToSuperview().offset(20)
      $0.height.equalTo(50)
    }
    
    certificationButton.snp.makeConstraints {
      $0.top.equalTo(phoneNumberTextField.snp.bottom).offset(10)
      $0.leading.equalTo(certificationNumberTextField.snp.trailing)
      $0.trailing.equalToSuperview().offset(-20)
      $0.height.equalTo(50)
      $0.width.equalTo(certificationNumberTextField.snp.width).multipliedBy(0.25)
    }
    
    signUpButton.snp.makeConstraints {
      $0.top.equalTo(certificationNumberTextField.snp.bottom).offset(40)
      $0.leading.equalTo(20)
      $0.trailing.equalTo(-20)
      $0.height.equalTo(50)
    }
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
