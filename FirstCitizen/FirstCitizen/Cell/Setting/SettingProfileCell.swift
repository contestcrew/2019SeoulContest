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
  private let creditLabel = UILabel()
  private let pointLabel = UILabel()
  
  
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
    
    creditLabel.text = "매너점수: 1200"
    creditLabel.upsFontBold(ofSize: 17)
    creditLabel.textColor = .black
    contentView.addSubview(creditLabel)
    
    pointLabel.text = "Point: 420"
    pointLabel.textColor = .black
    pointLabel.upsFontBold(ofSize: 17)
    contentView.addSubview(pointLabel)
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
    
    creditLabel.translatesAutoresizingMaskIntoConstraints = false
    creditLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
    creditLabel.topAnchor.constraint(equalTo: nickNameLabel.bottomAnchor, constant: Standard.ySpace).isActive = true
    
    pointLabel.translatesAutoresizingMaskIntoConstraints = false
    pointLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
    pointLabel.topAnchor.constraint(equalTo: creditLabel.bottomAnchor, constant: Standard.ySpace).isActive = true
    pointLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16).isActive = true
  }
}
