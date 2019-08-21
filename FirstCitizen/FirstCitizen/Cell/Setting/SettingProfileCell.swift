//
//  SettingProfileCell.swift
//  FirstCitizen
//
//  Created by Lee on 21/08/2019.
//  Copyright © 2019 Kira. All rights reserved.
//

import UIKit

class SettingProfileCell: UITableViewCell {

  static let identifier = "SettingProfileCell"
  
  private let topImageView = UIImageView()
  private let profileBaseView = UIView()
  private let profileImageView = UIImageView()
  private let profileImageEditButton = UIButton()
  private let nickNameLabel = UILabel()
  private let nickNameEditButton = UIButton()
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
    
    topImageView.image = UIImage(named: "seoul")
    topImageView.alpha = 0.3
    topImageView.contentMode = .scaleAspectFill
    topImageView.layer.masksToBounds = true
    contentView.addSubview(topImageView)
    
    profileBaseView.shadow()
    profileBaseView.layer.cornerRadius = 15
    profileBaseView.backgroundColor = .white
    contentView.addSubview(profileBaseView)
    
    profileImageView.image = UIImage(named: "ups")
    profileImageView.contentMode = .scaleAspectFill
    profileImageView.layer.cornerRadius = Standard.profileSize / 2
    profileImageView.layer.masksToBounds = true
    contentView.addSubview(profileImageView)
    
    profileImageEditButton.setImage(UIImage(named: "change"), for: .normal)
    profileImageEditButton.imageEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    profileImageEditButton.backgroundColor = #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1)
    profileImageEditButton.layer.cornerRadius = Standard.buttonSize / 2
    contentView.addSubview(profileImageEditButton)
    
    nickNameLabel.text = "닉네임 : 업's"
    nickNameLabel.textColor = .darkGray
    nickNameLabel.upsFontBold(ofSize: 15)
    contentView.addSubview(nickNameLabel)
    
    nickNameEditButton.setImage(UIImage(named: "pencil"), for: .normal)
    contentView.addSubview(nickNameEditButton)
    
    emailLabel.text = "이메일 : kria1021@gmail.com"
    emailLabel.textColor = .darkGray
    emailLabel.upsFontBold(ofSize: 15)
    contentView.addSubview(emailLabel)
    
    phoneNumberLabel.text = "휴대폰 번호 : 010-1111-1111"
    phoneNumberLabel.textColor = .darkGray
    phoneNumberLabel.upsFontBold(ofSize: 15)
    contentView.addSubview(phoneNumberLabel)
    
    phoneNumberCheckButton.setTitle("인증하기", for: .normal)
    phoneNumberCheckButton.setTitleColor(.blue, for: .normal)
    phoneNumberCheckButton.titleLabel?.upsFontBold(ofSize: 15)
    contentView.addSubview(phoneNumberCheckButton)

  }
  
  private struct Standard {
    static let space: CGFloat = 8
    
    static let profileSize: CGFloat = 112
    static let buttonSize: CGFloat = 32
  }
  
  private func autoLayout() {
    topImageView.translatesAutoresizingMaskIntoConstraints = false
    topImageView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
    topImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
    topImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
    topImageView.heightAnchor.constraint(equalToConstant: 240).isActive = true
    
    profileBaseView.translatesAutoresizingMaskIntoConstraints = false
    profileBaseView.centerYAnchor.constraint(equalTo: topImageView.bottomAnchor).isActive = true
    profileBaseView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 40).isActive = true
    profileBaseView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -40).isActive = true
    profileBaseView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16).isActive = true
    profileBaseView.heightAnchor.constraint(equalToConstant: 160).isActive = true
    
    profileImageView.translatesAutoresizingMaskIntoConstraints = false
    profileImageView.centerXAnchor.constraint(equalTo: profileBaseView.centerXAnchor).isActive = true
    profileImageView.centerYAnchor.constraint(equalTo: profileBaseView.topAnchor).isActive = true
    profileImageView.widthAnchor.constraint(equalToConstant: Standard.profileSize).isActive = true
    profileImageView.heightAnchor.constraint(equalToConstant: Standard.profileSize).isActive = true
    
    profileImageEditButton.translatesAutoresizingMaskIntoConstraints = false
    profileImageEditButton.trailingAnchor.constraint(equalTo: profileImageView.trailingAnchor).isActive = true
    profileImageEditButton.bottomAnchor.constraint(equalTo: profileImageView.bottomAnchor).isActive = true
    profileImageEditButton.widthAnchor.constraint(equalToConstant: Standard.buttonSize).isActive = true
    profileImageEditButton.heightAnchor.constraint(equalToConstant: Standard.buttonSize).isActive = true
    
    nickNameLabel.translatesAutoresizingMaskIntoConstraints = false
    nickNameLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 16).isActive = true
    nickNameLabel.leadingAnchor.constraint(equalTo: profileBaseView.leadingAnchor, constant: Standard.space).isActive = true
    
    nickNameEditButton.translatesAutoresizingMaskIntoConstraints = false
    nickNameEditButton.centerYAnchor.constraint(equalTo: nickNameLabel.centerYAnchor).isActive = true
    nickNameEditButton.trailingAnchor.constraint(equalTo: profileBaseView.trailingAnchor, constant: -Standard.space).isActive = true
    nickNameEditButton.widthAnchor.constraint(equalToConstant: 16).isActive = true
    nickNameEditButton.heightAnchor.constraint(equalToConstant: 16).isActive = true
    
    emailLabel.translatesAutoresizingMaskIntoConstraints = false
    emailLabel.topAnchor.constraint(equalTo: nickNameLabel.bottomAnchor, constant: Standard.space).isActive = true
    emailLabel.leadingAnchor.constraint(equalTo: profileBaseView.leadingAnchor, constant: Standard.space).isActive = true
    
    phoneNumberLabel.translatesAutoresizingMaskIntoConstraints = false
    phoneNumberLabel.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: Standard.space).isActive = true
    phoneNumberLabel.leadingAnchor.constraint(equalTo: profileBaseView.leadingAnchor, constant: Standard.space).isActive = true
    
    phoneNumberCheckButton.translatesAutoresizingMaskIntoConstraints = false
    phoneNumberCheckButton.centerYAnchor.constraint(equalTo: phoneNumberLabel.centerYAnchor).isActive = true
    phoneNumberCheckButton.trailingAnchor.constraint(equalTo: profileBaseView.trailingAnchor, constant: -Standard.space).isActive = true
  }

}
