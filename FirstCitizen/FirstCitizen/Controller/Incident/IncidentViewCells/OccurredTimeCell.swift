//
//  OccurredTimeCell.swift
//  FirstCitizen
//
//  Created by Fury on 24/09/2019.
//  Copyright © 2019 Kira. All rights reserved.
//

import UIKit

class OccurredTimeCell: UITableViewCell {
  
  static let identifier = "OccurredTimeCell"
  
  private let occurredTimeLabel = UILabel()
  private let occurredTimeUnderLineLabel = UILabel()
  private let occurredTimeText = UILabel()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    attribute()
    layout()
  }
  
  func modifyProperties(_ occurredTime: String) {
//    occurredTimeText.text = occurredTime
    
    let date = Date()
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
    let time = date.convertOccurredDateFormatter(date: occurredTime)
    let dateTime = dateFormatter.date(from: time)
    let daysBetweenDate = date.daysBetweenDate(toDate: dateTime!)
    
    occurredTimeText.text = daysBetweenDate
  }
  
  private func attribute() {
    occurredTimeLabel.text = "발생시각"
    occurredTimeLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    occurredTimeLabel.dynamicFont(fontSize: 24, weight: .bold)
    
    occurredTimeUnderLineLabel.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    
    occurredTimeText.text = "09:10"
    occurredTimeText.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    occurredTimeText.dynamicFont(fontSize: 16, weight: .bold)
  }
  
  private func layout() {
    let margin: CGFloat = 10
    
    [occurredTimeLabel, occurredTimeUnderLineLabel, occurredTimeText]
      .forEach { contentView.addSubview($0) }
    
    contentView.snp.makeConstraints {
      $0.leading.equalTo(self).offset(margin.dynamic(2))
      $0.trailing.equalTo(self).offset(-margin.dynamic(2))
    }
    
    occurredTimeLabel.snp.makeConstraints {
      $0.top.equalTo(contentView).offset(margin.dynamic(2))
      $0.leading.equalTo(contentView)
    }
    
    occurredTimeUnderLineLabel.snp.makeConstraints {
      $0.top.equalTo(occurredTimeLabel.snp.bottom).offset(margin.dynamic(2))
      $0.leading.trailing.equalTo(contentView)
      $0.height.equalTo(margin.dynamic(0.1))
    }
    
    occurredTimeText.snp.makeConstraints {
      $0.top.equalTo(occurredTimeUnderLineLabel.snp.bottom).offset(margin.dynamic(1))
      $0.leading.trailing.equalTo(contentView)
      $0.bottom.equalTo(contentView).offset(-margin.dynamic(1))
    }
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
