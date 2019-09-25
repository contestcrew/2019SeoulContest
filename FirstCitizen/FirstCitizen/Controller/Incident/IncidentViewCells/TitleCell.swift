//
//  TitleCell.swift
//  FirstCitizen
//
//  Created by Fury on 24/09/2019.
//  Copyright © 2019 Kira. All rights reserved.
//

import UIKit

class TitleCell: UITableViewCell {
  
  static let identifier = "TitleCell"
  
  private let titleLabel = UILabel()
  private let iconImageView = UIImageView()
  private let titleUnderLineLabel = UILabel()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    attribute()
    layout()
  }
  
  private func attribute() {
    titleLabel.text = "하늘에서 날개를 ..."
    titleLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    titleLabel.dynamicFont(fontSize: 28, weight: .bold)
    
    iconImageView.contentMode = .scaleAspectFit
    iconImageView.image = #imageLiteral(resourceName: "Restroom")
    
    titleUnderLineLabel.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
  }
  
  private func layout() {
    let margin: CGFloat = 10
    
    [titleLabel, iconImageView, titleUnderLineLabel]
      .forEach { contentView.addSubview($0) }
    
    contentView.snp.makeConstraints {
      $0.leading.equalTo(self).offset(margin.dynamic(2))
      $0.trailing.equalTo(self).offset(-margin.dynamic(2))
    }
    
    titleLabel.snp.makeConstraints {
      $0.top.trailing.equalTo(contentView)
      $0.leading.equalTo(contentView)
    }
    
    iconImageView.snp.makeConstraints {
      $0.centerY.equalTo(titleLabel.snp.centerY)
      $0.trailing.equalTo(contentView)
      $0.width.height.equalTo(margin.dynamic(3) + 5)
    }
    
    titleUnderLineLabel.snp.makeConstraints {
      $0.top.equalTo(titleLabel.snp.bottom).offset(margin.dynamic(1))
      $0.leading.trailing.bottom.equalTo(contentView)
      $0.height.equalTo(margin.dynamic(0.1))
    }
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
