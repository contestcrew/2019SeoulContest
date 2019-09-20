//
//  ReportView.swift
//  FirstCitizen
//
//  Created by Fury on 19/09/2019.
//  Copyright © 2019 Kira. All rights reserved.
//

import UIKit

protocol ReportViewDelegate: class {
  func touchUpReportButton()
  func touchUpBackButton()
}

class ReportView: UIView {
  
  weak var delegate: ReportViewDelegate?
  
  private let backButton = UIButton()
  private let reportHedaerTitleLabel = UILabel()
  private let reportButton = UIButton()
  
  private let titleLabel = UILabel()
  let titleTextField = UITextField()
  
  private let contentsLabel = UILabel()
  let contentsTextField = UITextField()
  
  private let attachFileLabel = UILabel()
  private let attachFileButton = UIButton()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    layout()
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    
    attribute()
  }
  
  @objc private func touchUpReportButton() {
    delegate?.touchUpReportButton()
  }
  
  @objc private func touchUpBackButton() {
    delegate?.touchUpBackButton()
  }
  
  private func attribute() {
    backButton.setImage(#imageLiteral(resourceName: "Back_Button"), for: .normal)
    backButton.addTarget(self, action: #selector(touchUpBackButton), for: .touchUpInside)
    
    reportHedaerTitleLabel.text = "제보하기"
    reportHedaerTitleLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    reportHedaerTitleLabel.upsFontHeavy(ofSize: 26)
    
    reportButton.setTitle("제보", for: .normal)
    reportButton.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
    reportButton.titleLabel?.font = UIFont.systemFont(ofSize: 22, weight: .heavy)
    reportButton.contentEdgeInsets = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
    reportButton.backgroundColor = #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)
    reportButton.layer.cornerRadius = 5
    reportButton.addTarget(self, action: #selector(touchUpReportButton), for: .touchUpInside)
    
    titleLabel.text = "타이틀 (필수)"
    titleLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    titleLabel.upsFontHeavy(ofSize: 24)
    let titleAttributedStr = NSMutableAttributedString(string: titleLabel.text!)
    titleAttributedStr.addAttribute(.foregroundColor, value: UIColor.green, range: (titleLabel.text! as NSString).range(of: "(필수)"))
    titleAttributedStr.addAttribute(.font, value: UIFont.systemFont(ofSize: 16, weight: .heavy), range: (titleLabel.text! as NSString).range(of: "(필수)"))
    titleLabel.attributedText = titleAttributedStr
    
    titleTextField.borderStyle = .roundedRect
    titleTextField.layer.borderWidth = 2
    titleTextField.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
    titleTextField.layer.cornerRadius = 5
    titleTextField.clearButtonMode = .whileEditing
    titleTextField.keyboardType = .default
    titleTextField.returnKeyType = .continue
    
    contentsLabel.text = "메세지 (필수)"
    contentsLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    contentsLabel.upsFontHeavy(ofSize: 24)
    let contentsAttributedStr = NSMutableAttributedString(string: contentsLabel.text!)
    contentsAttributedStr.addAttribute(.foregroundColor, value: UIColor.green, range: (contentsLabel.text! as NSString).range(of: "(필수)"))
    contentsAttributedStr.addAttribute(.font, value: UIFont.systemFont(ofSize: 16, weight: .heavy), range: (contentsLabel.text! as NSString).range(of: "(필수)"))
    contentsLabel.attributedText = contentsAttributedStr
    
    contentsTextField.borderStyle = .roundedRect
    contentsTextField.layer.borderWidth = 2
    contentsTextField.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
    contentsTextField.layer.cornerRadius = 5
    contentsTextField.textAlignment = .justified
    contentsTextField.clearButtonMode = .whileEditing
    contentsTextField.keyboardType = .default
    contentsTextField.returnKeyType = .done
    
    attachFileLabel.text = "파일 첨부 (선택)"
    attachFileLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    attachFileLabel.upsFontHeavy(ofSize: 24)
    let attachFileAttributedStr = NSMutableAttributedString(string: attachFileLabel.text!)
    attachFileAttributedStr.addAttribute(.foregroundColor, value: UIColor.red, range: (attachFileLabel.text! as NSString).range(of: "(선택)"))
    attachFileAttributedStr.addAttribute(.font, value: UIFont.systemFont(ofSize: 16, weight: .heavy), range: (attachFileLabel.text! as NSString).range(of: "(선택)"))
    attachFileLabel.attributedText = attachFileAttributedStr
    
    attachFileButton.setImage(#imageLiteral(resourceName: "icons8-plus-math-30"), for: .normal)
    attachFileButton.contentMode = .scaleAspectFit
    attachFileButton.backgroundColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
    attachFileButton.layer.cornerRadius = 5
  }
  
  private func layout() {
    [backButton, reportHedaerTitleLabel, reportButton, titleLabel, titleTextField, contentsLabel, contentsTextField, attachFileLabel, attachFileButton].forEach { self.addSubview($0) }
    
    backButton.snp.makeConstraints {
      $0.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(10)
      $0.leading.equalTo(self.safeAreaLayoutGuide.snp.leading).offset(10)
      $0.width.height.equalTo(35)
    }
    
    reportHedaerTitleLabel.snp.makeConstraints {
      $0.centerX.equalToSuperview()
      $0.centerY.equalTo(backButton.snp.centerY)
    }
    
    reportButton.snp.makeConstraints {
      $0.centerY.equalTo(reportHedaerTitleLabel.snp.centerY)
      $0.trailing.equalTo(self.safeAreaLayoutGuide.snp.trailing).offset(-20)
      $0.height.equalTo(35)
    }
    
    titleLabel.snp.makeConstraints {
      $0.top.equalTo(backButton.snp.bottom).offset(40)
      $0.leading.equalToSuperview().offset(20)
    }
    
    titleTextField.snp.makeConstraints {
      $0.top.equalTo(titleLabel.snp.bottom).offset(20)
      $0.leading.equalToSuperview().offset(20)
      $0.trailing.equalToSuperview().offset(-20)
      $0.height.equalTo(40)
    }
    
    contentsLabel.snp.makeConstraints {
      $0.top.equalTo(titleTextField.snp.bottom).offset(20)
      $0.leading.equalToSuperview().offset(20)
    }
    
    contentsTextField.snp.makeConstraints {
      $0.top.equalTo(contentsLabel.snp.bottom).offset(20)
      $0.leading.equalToSuperview().offset(20)
      $0.trailing.equalToSuperview().offset(-20)
      $0.height.equalTo(150)
    }
    
    attachFileLabel.snp.makeConstraints {
      $0.top.equalTo(contentsTextField.snp.bottom).offset(20)
      $0.leading.equalToSuperview().offset(20)
    }
    
    attachFileButton.snp.makeConstraints {
      $0.top.equalTo(contentsTextField.snp.bottom).offset(20)
      $0.trailing.equalToSuperview().offset(-20)
      $0.width.height.equalTo(35)
    }
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
