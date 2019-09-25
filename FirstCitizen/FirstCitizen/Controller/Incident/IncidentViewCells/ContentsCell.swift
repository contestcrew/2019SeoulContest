//
//  ContentsCell.swift
//  FirstCitizen
//
//  Created by Fury on 24/09/2019.
//  Copyright © 2019 Kira. All rights reserved.
//

import UIKit

class ContentsCell: UITableViewCell {
  
  static let identifier = "ContentsCell"
  
  private let contentsTitleLabel = UILabel()
  private let contentsUnderLineLabel = UILabel()
  private let contentsLabel = UILabel()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    attribute()
    layout()
  }
  
  func modifyProperties(_ contents: String) {
    contentsLabel.text = contents
  }
  
  private func attribute() {
    contentsTitleLabel.text = "내용"
    contentsTitleLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    contentsTitleLabel.dynamicFont(fontSize: 24, weight: .bold)
    
    contentsUnderLineLabel.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    
    contentsLabel.text = "내 날개좀.. 찾아주세요.. 부탁드려요 ㅠㅠㅠㅠ"
    contentsLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    contentsLabel.textAlignment = .justified
    contentsLabel.dynamicFont(fontSize: 16, weight: .bold)
    contentsLabel.numberOfLines = 0
  }
  
  private func layout() {
    let margin: CGFloat = 10
    
    [contentsTitleLabel, contentsUnderLineLabel, contentsLabel].forEach { contentView.addSubview($0) }
    
    contentsTitleLabel.snp.makeConstraints {
      $0.top.equalTo(contentView).offset(margin.dynamic(2))
      $0.leading.equalTo(contentView).offset(margin.dynamic(2))
      $0.trailing.equalTo(contentView).offset(-margin.dynamic(2))
    }
    
    contentsUnderLineLabel.snp.makeConstraints {
      $0.top.equalTo(contentsTitleLabel.snp.bottom).offset(margin.dynamic(1))
      $0.leading.equalTo(contentsTitleLabel.snp.leading)
      $0.trailing.equalTo(contentsTitleLabel.snp.trailing)
      $0.height.equalTo(margin.dynamic(0.1))
    }
    
    contentsLabel.snp.makeConstraints {
      $0.top.equalTo(contentsUnderLineLabel.snp.bottom).offset(margin.dynamic(1))
      $0.leading.equalTo(contentsTitleLabel.snp.leading)
      $0.trailing.equalTo(contentsTitleLabel.snp.trailing)
      $0.bottom.equalTo(contentView).offset(-margin.dynamic(2))
    }
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
