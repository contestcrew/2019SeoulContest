//
//  RequestDetailHelpCell.swift
//  FirstCitizen
//
//  Created by Fury on 26/09/2019.
//  Copyright © 2019 Kira. All rights reserved.
//

import UIKit

class RequestDetailHelpCell: UITableViewCell {
  static let identifier = "RequestDetailHelpCell"
  
  var category = ""
  
  private let nicknameLabel = UILabel()
  private let reliabilityLabel = UILabel()
  private let attachFileCountLabel = UILabel()
  
  private let acceptButton = UIButton()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    
    attribute()
    layout()
  }
  
  private func attribute() {
    nicknameLabel.text = "did**************"
    nicknameLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    
    reliabilityLabel.text = "신뢰도 : 100"
    reliabilityLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    reliabilityLabel.textAlignment = .center
    
    attachFileCountLabel.text = "첨부파일 : 0"
    attachFileCountLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    attachFileCountLabel.textAlignment = .center
    
    if category == "Restroom" {
      acceptButton.setTitle("수락", for: .normal)
      acceptButton.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
      acceptButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .heavy)
    } else {
      acceptButton.setImage(#imageLiteral(resourceName: "arrow"), for: .normal)
      acceptButton.contentMode = .scaleAspectFit
    }
  }
  
  private func layout() {
    [nicknameLabel, reliabilityLabel, acceptButton].forEach { contentView.addSubview($0) }
    
    nicknameLabel.snp.makeConstraints {
      $0.top.leading.equalToSuperview().offset(10)
    }
    
    reliabilityLabel.snp.makeConstraints {
      $0.top.equalTo(nicknameLabel.snp.bottom).offset(10)
      $0.leading.equalToSuperview().offset(10)
      $0.bottom.equalToSuperview().offset(-10)
      $0.height.equalTo(nicknameLabel.snp.height)
    }
    
    acceptButton.snp.makeConstraints {
      $0.top.trailing.bottom.equalToSuperview()
    }
    
    if category != "Restroom" {
      contentView.addSubview(attachFileCountLabel)
      
      attachFileCountLabel.snp.makeConstraints {
        $0.top.equalTo(nicknameLabel.snp.bottom).offset(10)
        $0.leading.equalTo(reliabilityLabel.snp.trailing)
        $0.trailing.equalTo(acceptButton.snp.leading)
        $0.bottom.equalTo(contentView)
        $0.width.equalTo(reliabilityLabel.snp.width)
      }
    }
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
