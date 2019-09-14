//
//  SettingProfileCell.swift
//  FirstCitizen
//
//  Created by Lee on 21/08/2019.
//  Copyright © 2019 Kira. All rights reserved.
//

import UIKit
import SnapKit

class SettingProfileCell: UITableViewCell {

  static let identifier = "SettingProfileCell"
  
  private let topImageView = UIImageView()
  private let nickNameLabel = UILabel()
  private let nickNameEditButton = UIButton()
  private let mannerLabel = UILabel()
  private let pointLabel = UILabel()
  private let emailLabel = UILabel()
  private let phoneNumberLabel = UILabel()
  private let phoneNumberCheckButton = UIButton()
  
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    configure()
    autoLayout()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func configure() {
    self.selectionStyle = .none
    
    topImageView.image = UIImage(named: "leaf")
    topImageView.contentMode = .scaleAspectFill
    topImageView.layer.masksToBounds = true
    contentView.addSubview(topImageView)
    
    nickNameLabel.text = "닉네임 : 업's"
    nickNameLabel.textColor = .darkGray
    nickNameLabel.upsFontBold(ofSize: 17)
    contentView.addSubview(nickNameLabel)
    
    nickNameEditButton.setTitle("수정", for: .normal)
    nickNameEditButton.setTitleColor(self.tintColor, for: .normal)
    nickNameEditButton.titleLabel?.upsFont(ofSize: 15)
    contentView.addSubview(nickNameEditButton)
    
    mannerLabel.text = "매너점수: 1200"
    mannerLabel.upsFontBold(ofSize: 17)
    mannerLabel.textColor = .black
    contentView.addSubview(mannerLabel)
    
    pointLabel.text = "Point: 420"
    pointLabel.textColor = .black
    pointLabel.upsFontBold(ofSize: 17)
    contentView.addSubview(pointLabel)
    
    emailLabel.text = "이메일 : dldbdjq@gmail.com"
    emailLabel.textColor = .darkGray
    emailLabel.upsFontBold(ofSize: 15)
    contentView.addSubview(emailLabel)
    
    phoneNumberLabel.text = "휴대폰 번호 : 010-1111-1111"
    phoneNumberLabel.textColor = .darkGray
    phoneNumberLabel.upsFontBold(ofSize: 15)
    contentView.addSubview(phoneNumberLabel)
    
    phoneNumberCheckButton.setTitle("인증하기", for: .normal)
    phoneNumberCheckButton.setTitleColor(self.tintColor, for: .normal)
    phoneNumberCheckButton.titleLabel?.upsFont(ofSize: 15)
    contentView.addSubview(phoneNumberCheckButton)
  }
  
  private struct Standard {
    static let space: CGFloat = 8
    static let xSpace: CGFloat = 8
    static let ySpace: CGFloat = 8
    
    static let topImageSize: CGFloat = 112
    static let buttonSize: CGFloat = 24
  }
  
  private func autoLayout() {
    topImageView.translatesAutoresizingMaskIntoConstraints = false
    topImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
    topImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16).isActive = true
    topImageView.widthAnchor.constraint(equalToConstant: Standard.topImageSize).isActive = true
    topImageView.heightAnchor.constraint(equalToConstant: Standard.topImageSize).isActive = true
    
    nickNameLabel.translatesAutoresizingMaskIntoConstraints = false
    nickNameLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
    nickNameLabel.topAnchor.constraint(equalTo: topImageView.bottomAnchor, constant: Standard.xSpace).isActive = true

    nickNameEditButton.translatesAutoresizingMaskIntoConstraints = false
    nickNameEditButton.centerYAnchor.constraint(equalTo: nickNameLabel.centerYAnchor).isActive = true
    nickNameEditButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Standard.xSpace).isActive = true
    
    mannerLabel.translatesAutoresizingMaskIntoConstraints = false
    mannerLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
    mannerLabel.topAnchor.constraint(equalTo: nickNameLabel.bottomAnchor, constant: Standard.ySpace).isActive = true
    
    pointLabel.translatesAutoresizingMaskIntoConstraints = false
    pointLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
    pointLabel.topAnchor.constraint(equalTo: mannerLabel.bottomAnchor, constant: Standard.ySpace).isActive = true

    emailLabel.translatesAutoresizingMaskIntoConstraints = false
    emailLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
    emailLabel.topAnchor.constraint(equalTo: pointLabel.bottomAnchor, constant: Standard.ySpace).isActive = true

    phoneNumberLabel.translatesAutoresizingMaskIntoConstraints = false
    phoneNumberLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
    phoneNumberLabel.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: Standard.ySpace).isActive = true
    phoneNumberLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16).isActive = true

    phoneNumberCheckButton.translatesAutoresizingMaskIntoConstraints = false
    phoneNumberCheckButton.centerYAnchor.constraint(equalTo: phoneNumberLabel.centerYAnchor).isActive = true
    phoneNumberCheckButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Standard.xSpace).isActive = true
  }
}
