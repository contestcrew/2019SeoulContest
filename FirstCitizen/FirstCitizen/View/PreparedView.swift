//
//  PreparedView.swift
//  FirstCitizen
//
//  Created by Fury on 26/08/2019.
//  Copyright © 2019 Kira. All rights reserved.
//

import UIKit
import SnapKit

protocol PreparedViewDelegate: class {
  func touchUpBackButton()
  func touchUpNextButton()
}

class PreparedView: UIView {
  
  weak var delegate: PreparedViewDelegate?
  
  private let backButton = UIButton()
  
  private let nicknameExplainLabel = UILabel()
  private let nicknametextLabel = UILabel()
  private let nicknameTextField = UITextField()
  private let nicknameValidCheckImageView = UIImageView()
  
  private let textFieldUnderlineView = UIView()
  private let nicknameLimitShowLabel = UILabel()
  
  let nextButton = UIButton()
  
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    attribute()
    layout()
  }
  
  @objc private func touchUpBackButton() {
    delegate?.touchUpBackButton()
  }
  
  @objc private func touchUpNextButton() {
    delegate?.touchUpNextButton()
  }
  
  private func attribute() {
    backButton.setImage(#imageLiteral(resourceName: "Back_Button"), for: .normal)
    backButton.contentMode = .scaleAspectFit
    backButton.addTarget(self, action: #selector(touchUpBackButton), for: .touchUpInside)
    
    nicknameExplainLabel.text =
    """
    닉네임을
    입력해 주세요.
    """
    nicknameExplainLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    nicknameExplainLabel.font = UIFont.systemFont(ofSize: 30, weight: .black)
    nicknameExplainLabel.numberOfLines = 0
    
    nicknametextLabel.text = "닉네임"
    nicknametextLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    nicknametextLabel.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
    
    
    nicknameTextField.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    nicknameTextField.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
    nicknameTextField.delegate = self
    
    nicknameValidCheckImageView.image = #imageLiteral(resourceName: "Default_Check_Icon")
    nicknameValidCheckImageView.contentMode = .scaleAspectFit
    nicknameValidCheckImageView.isHidden = true
    
    textFieldUnderlineView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    
    nicknameLimitShowLabel.text =
    """
    * 닉네임은 최소 2자 최대 8자까지 가능합니다.
    * 기호, 특수문자 등은 포함될 수 없습니다.
    """
    nicknameLimitShowLabel.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
    nicknameLimitShowLabel.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
    nicknameLimitShowLabel.numberOfLines = 0
    
    nextButton.setTitle("계속", for: .normal)
    nextButton.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
    nextButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
    nextButton.contentEdgeInsets = UIEdgeInsets.init(top: 15, left: 25, bottom: 15, right: 25)
    nextButton.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    nextButton.layer.borderWidth = 1
    nextButton.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
    nextButton.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    nextButton.layer.shadowRadius = 2
    nextButton.layer.shadowOffset = CGSize(width: 3, height: 3)
    nextButton.layer.shadowOpacity = 1
    nextButton.layer.cornerRadius = 4
    nextButton.addTarget(self, action: #selector(touchUpNextButton), for: .touchUpInside)
  }
  
  private func layout() {
    let guide = self.safeAreaLayoutGuide
    
    self.addSubview(backButton)
    self.addSubview(nicknameExplainLabel)
    self.addSubview(nicknametextLabel)
    self.addSubview(nicknameTextField)
    self.addSubview(nicknameValidCheckImageView)
    self.addSubview(textFieldUnderlineView)
    self.addSubview(nicknameLimitShowLabel)
    self.addSubview(nextButton)
    
    backButton.snp.makeConstraints {
      $0.top.equalTo(guide.snp.top).offset(10)
      $0.leading.equalTo(guide.snp.leading).offset(10)
      $0.width.height.equalTo(30)
    }
    
    nicknameExplainLabel.snp.makeConstraints {
      $0.top.equalTo(backButton.snp.bottom).offset(20)
      $0.leading.equalTo(guide.snp.leading).offset(20)
      $0.height.equalTo(80)
    }
    
    nicknametextLabel.snp.makeConstraints {
      $0.top.equalTo(nicknameExplainLabel.snp.bottom).offset(20)
      $0.leading.equalTo(guide.snp.leading).offset(20)
    }
    
    nicknameTextField.snp.makeConstraints {
      $0.top.equalTo(nicknametextLabel.snp.bottom).offset(30)
      $0.leading.equalTo(guide.snp.leading).offset(20)
      $0.trailing.equalTo(guide.snp.trailing).offset(-20)
    }
    
    nicknameValidCheckImageView.snp.makeConstraints {
      $0.top.equalTo(nicknametextLabel.snp.bottom).offset(30)
      $0.trailing.equalTo(guide.snp.trailing).offset(-20)
      $0.bottom.equalTo(nicknameTextField.snp.bottom)
      $0.width.height.equalTo(30)
    }
    
    textFieldUnderlineView.snp.makeConstraints {
      $0.top.equalTo(nicknameTextField.snp.bottom).offset(5)
      $0.leading.equalTo(guide.snp.leading).offset(20)
      $0.trailing.equalTo(guide.snp.trailing).offset(-20)
      $0.height.equalTo(1)
    }
    
    nicknameLimitShowLabel.snp.makeConstraints {
      $0.top.equalTo(textFieldUnderlineView.snp.bottom).offset(10)
      $0.leading.equalTo(guide.snp.leading).offset(20)
      
    }
    
    nextButton.snp.makeConstraints {
      $0.trailing.equalTo(guide.snp.trailing).offset(-20)
      $0.bottom.equalTo(guide.snp.bottom).offset(-20)
    }
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension PreparedView: UITextFieldDelegate {
  func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    let newLength = (textField.text?.count)! + string.count - range.length
    if newLength >= 2 && newLength <= 8 {
      nicknameValidCheckImageView.isHidden = false
    } else {
      nicknameValidCheckImageView.isHidden = true
    }
    return true
  }
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    nicknameTextField.resignFirstResponder()
    return true
  }
}
