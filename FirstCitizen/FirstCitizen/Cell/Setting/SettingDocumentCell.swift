//
//  SettingDocumentCell.swift
//  FirstCitizen
//
//  Created by Lee on 22/09/2019.
//  Copyright © 2019 Kira. All rights reserved.
//

import UIKit

class SettingDocumentCell: UITableViewCell {

  static let identifier = "SettingDocumentCell"
  
  let titleLabel = UILabel()
  let countLabel = UILabel()
  let detailImageView = UIImageView()
  
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
    
    titleLabel.upsFontHeavy(ofSize: 20)
    contentView.addSubview(titleLabel)
    
    countLabel.isHidden = true
    countLabel.dynamicFont(fontSize: 15, weight: .bold)
    countLabel.backgroundColor = .blue
    countLabel.layer.cornerRadius = 8
    countLabel.layer.masksToBounds = true
    countLabel.textColor = .white
    countLabel.textAlignment = .center
    contentView.addSubview(countLabel)
    
    detailImageView.image = UIImage(named: "arrow")
    detailImageView.contentMode = .scaleAspectFit
    contentView.addSubview(detailImageView)
  }
  
  private struct Standard {
    static let space: CGFloat = 8
    static let imageSize: CGFloat = 24
  }
  
  private func autoLayout() {
    titleLabel.translatesAutoresizingMaskIntoConstraints = false
    titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
    titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
    
    countLabel.translatesAutoresizingMaskIntoConstraints = false
    countLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
    countLabel.trailingAnchor.constraint(equalTo: detailImageView.leadingAnchor, constant: -16).isActive = true
    countLabel.widthAnchor.constraint(equalToConstant: Standard.imageSize).isActive = true
    countLabel.heightAnchor.constraint(equalToConstant: Standard.imageSize).isActive = true
    
    detailImageView.translatesAutoresizingMaskIntoConstraints = false
    detailImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Standard.space).isActive = true
    detailImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Standard.space).isActive = true
    detailImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Standard.space).isActive = true
    detailImageView.widthAnchor.constraint(equalToConstant: Standard.imageSize).isActive = true
    detailImageView.heightAnchor.constraint(equalToConstant: Standard.imageSize).isActive = true
  }
}
