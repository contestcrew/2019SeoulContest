//
//  PointStampCell.swift
//  FirstCitizen
//
//  Created by Lee on 28/09/2019.
//  Copyright © 2019 Kira. All rights reserved.
//

import UIKit

class PointStampCell: UITableViewCell {

  static let identifier = "PointStampCell"
  
  private let stampImageView = UIImageView()
  private let displayLabel = UILabel()
  
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
    
    stampImageView.image = #imageLiteral(resourceName: "stamp")
    stampImageView.contentMode = .scaleAspectFit
    contentView.addSubview(stampImageView)
    
    displayLabel.text = "추울석췌익크"
    displayLabel.upsFontHeavy(ofSize: 25)
    displayLabel.textColor = .darkGray
    contentView.addSubview(displayLabel)
  }
  
  private struct Standard {
    static let space: CGFloat = 8
  }
  
  private func autoLayout() {
    stampImageView.translatesAutoresizingMaskIntoConstraints = false
    stampImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0).isActive = true
    stampImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 64).isActive = true
    stampImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16).isActive = true
    stampImageView.widthAnchor.constraint(equalToConstant: 48).isActive = true
    stampImageView.heightAnchor.constraint(equalToConstant: 48).isActive = true
    
    displayLabel.translatesAutoresizingMaskIntoConstraints = false
    displayLabel.centerYAnchor.constraint(equalTo: stampImageView.centerYAnchor).isActive = true
    displayLabel.leadingAnchor.constraint(equalTo: stampImageView.trailingAnchor, constant: 24).isActive = true
  }
}
