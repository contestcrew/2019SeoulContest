//
//  SettingItemCell.swift
//  FirstCitizen
//
//  Created by Lee on 11/09/2019.
//  Copyright © 2019 Kira. All rights reserved.
//

import UIKit

class SettingItemCell: UICollectionViewCell {
  
  static let identifier = "SettingItemCell"
  
  private let imageView = UIImageView()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    configure()
    autoLayout()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func setting(item: String) {
    imageView.image = UIImage(named: item)
  }
  
  private func configure() {
    imageView.contentMode = .scaleAspectFit
    contentView.addSubview(imageView)
  }
  
  private struct Standard {
    static let space: CGFloat = 10
  }
  
  private func autoLayout() {
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
    imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
    imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
    imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
  }
}
