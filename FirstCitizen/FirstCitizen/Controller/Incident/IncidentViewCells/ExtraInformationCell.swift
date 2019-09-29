//
//  ExtraInfomaitionCell.swift
//  FirstCitizen
//
//  Created by Fury on 24/09/2019.
//  Copyright © 2019 Kira. All rights reserved.
//

import UIKit

class ExtraInfomaitionCell: UITableViewCell {
  
  static let identifier = "ExtraInfomaitionCell"
  
  private let regionLabel = UILabel()
  private let pointLabel = UILabel()
  private let uploadTimeLabel = UILabel()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    attribute()
    layout()
  }
  
  func modifyProperties(_ regionName: String, _ point: String, _ uploadTime: String) {
    regionLabel.text = regionName
    pointLabel.text = point
    let attributedStr = NSMutableAttributedString(string: pointLabel.text!)
    attributedStr.addAttribute(.foregroundColor, value: UIColor.blue, range: (pointLabel.text! as NSString).range(of: "Bonus"))
    attributedStr.addAttribute(.foregroundColor, value: UIColor.orange, range: (pointLabel.text! as NSString).range(of: "Point"))
    pointLabel.attributedText = attributedStr
    
    let date = Date()
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
    let time = date.convertDateFormatter(date: uploadTime)
    let dateTime = dateFormatter.date(from: time)
    let daysBetweenDate = date.daysBetweenDate(toDate: dateTime!)
    
    uploadTimeLabel.text = daysBetweenDate
  }
  
  private func attribute() {
    regionLabel.text = "서울특별시 성동구 성수22길 37, 사거리"
    regionLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    regionLabel.dynamicFont(fontSize: 14, weight: .semibold)
    regionLabel.numberOfLines = 0
    regionLabel.textAlignment = .right
    
    pointLabel.text = "Point 1000 + Bonus 50"
    pointLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    pointLabel.dynamicFont(fontSize: 14, weight: .semibold)
    
    uploadTimeLabel.text = "2019-06-04 목요일"
    uploadTimeLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    uploadTimeLabel.dynamicFont(fontSize: 14, weight: .semibold)
  }
  
  private func layout() {
    let margin: CGFloat = 10
    
    [regionLabel, pointLabel, uploadTimeLabel]
      .forEach { contentView.addSubview($0) }
    
    regionLabel.snp.makeConstraints {
      $0.top.equalTo(contentView).offset(margin.dynamic(1))
      $0.leading.equalTo(self).offset(margin.dynamic(2))
      $0.trailing.equalTo(self).offset(-margin.dynamic(2))
    }
    
    pointLabel.snp.makeConstraints {
      $0.top.equalTo(regionLabel.snp.bottom).offset(margin.dynamic(1))
      $0.trailing.equalTo(regionLabel.snp.trailing)
    }
    
    uploadTimeLabel.snp.makeConstraints {
      $0.top.equalTo(pointLabel.snp.bottom).offset(margin.dynamic(1))
      $0.trailing.equalTo(regionLabel.snp.trailing)
      $0.bottom.equalTo(contentView).offset(-margin.dynamic(1))
    }
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
