//
//  SettingItemAddCell.swift
//  FirstCitizen
//
//  Created by Lee on 11/09/2019.
//  Copyright © 2019 Kira. All rights reserved.
//

import UIKit

class SettingItemAddCell: UICollectionViewCell {
  
  static let identifier = "SettingItemAddCell"
  
  private let addLabel = UILabel()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    configure()
    autoLayout()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func configure() {
    contentView.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
    contentView.layer.cornerRadius = 16
    contentView.layer.masksToBounds = true
    
    addLabel.text = "✚"
    addLabel.upsFontHeavy(ofSize: 40)
    addLabel.textAlignment = .center
    addLabel.textColor = .white
    contentView.addSubview(addLabel)
  }
  
  private struct Standard {
    static let space: CGFloat = 10
  }
  
  private func autoLayout() {
    addLabel.translatesAutoresizingMaskIntoConstraints = false
    addLabel.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
    addLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
    addLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
    addLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
  }
}
