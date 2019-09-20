
//
//  ListViewCell.swift
//  FirstCitizen
//
//  Created by Fury on 20/09/2019.
//  Copyright © 2019 Kira. All rights reserved.
//

import UIKit

class ListViewCell: UITableViewCell {
  
  static let identifier = "ListViewCell"
  
  private let iconImage = UIImageView()
  private let titleLabel = UILabel()
  private let guideLabel = UILabel()
  private let dateLabel = UILabel()
  private let pointLabel = UILabel()
  private let contentsLabel = UILabel()
  private let progressLabel = UILabel()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    attribute()
    layout()
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    
    contentView.layer.cornerRadius = 10
  }
  
  func changePreviewContainer(_ homeIncidentData: HomeIncidentData) {
    titleLabel.text = homeIncidentData.title
    dateLabel.text = homeIncidentData.uploadTime
    contentsLabel.text = homeIncidentData.contents
    pointLabel.text = "Point \(homeIncidentData.servicePoint) + Bonus \(homeIncidentData.userPoint)"
    let attributedStr = NSMutableAttributedString(string: pointLabel.text!)
    attributedStr.addAttribute(.foregroundColor, value: UIColor.blue, range: (pointLabel.text! as NSString).range(of: "Bonus"))
    attributedStr.addAttribute(.foregroundColor, value: UIColor.orange, range: (pointLabel.text! as NSString).range(of: "Point"))
    pointLabel.attributedText = attributedStr
  }
  
  private func attribute() {
    iconImage.contentMode = .scaleAspectFit
    iconImage.image = #imageLiteral(resourceName: "Restroom")
    
    titleLabel.upsFontHeavy(ofSize: 26)
    titleLabel.text = "굳어가고 있어요 헬프미"
    
    guideLabel.backgroundColor = .black
    
    dateLabel.upsFontHeavy(ofSize: 13)
    dateLabel.text = "2019-08-14 목요일"
    
    pointLabel.text = "Point 100 + Bonus 350"
    pointLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    pointLabel.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
    let attributedStr = NSMutableAttributedString(string: pointLabel.text!)
    attributedStr.addAttribute(.foregroundColor, value: UIColor.blue, range: (pointLabel.text! as NSString).range(of: "Bonus"))
    attributedStr.addAttribute(.foregroundColor, value: UIColor.orange, range: (pointLabel.text! as NSString).range(of: "Point"))
    pointLabel.attributedText = attributedStr
    
    contentsLabel.upsFontBold(ofSize: 15)
    contentsLabel.textColor = .darkGray
    contentsLabel.text = "굳어가고 있어요.. 헬퓨ㅡ미.."
    
    progressLabel.upsFontHeavy(ofSize: 22)
    progressLabel.text = "도움요청중"
    progressLabel.textAlignment = .center
    progressLabel.textColor = #colorLiteral(red: 0.03933401406, green: 0.7532997727, blue: 0.2689341307, alpha: 1)
  }
  
  private func layout() {
    [titleLabel, iconImage, guideLabel, dateLabel, pointLabel, contentsLabel, progressLabel]
      .forEach { contentView.addSubview($0) }
    
    titleLabel.snp.makeConstraints {
      $0.top.equalToSuperview().offset(20)
      $0.leading.equalToSuperview().offset(10)
    }
    
    iconImage.snp.makeConstraints {
      $0.centerY.equalTo(titleLabel.snp.centerY)
      $0.trailing.equalToSuperview().offset(-10)
      $0.width.height.equalTo(40)
    }
    
    guideLabel.snp.makeConstraints {
      $0.top.equalTo(titleLabel.snp.bottom).offset(20)
      $0.leading.equalToSuperview().offset(10)
      $0.trailing.equalToSuperview().offset(-10)
      $0.height.equalTo(2)
    }
    
    dateLabel.snp.makeConstraints {
      $0.top.equalTo(guideLabel.snp.bottom).offset(10)
      $0.leading.equalToSuperview().offset(10)
    }
    
    pointLabel.snp.makeConstraints {
      $0.top.equalTo(guideLabel.snp.bottom).offset(10)
      $0.trailing.equalToSuperview().offset(-10)
    }
    
    contentsLabel.snp.makeConstraints {
      $0.top.equalTo(dateLabel.snp.bottom).offset(20)
      $0.leading.equalToSuperview().offset(10)
    }
    
    progressLabel.snp.makeConstraints {
      $0.leading.equalTo(contentsLabel.snp.trailing)
      $0.centerY.equalTo(contentsLabel.snp.centerY)
      $0.trailing.equalToSuperview().offset(-20)
      $0.width.equalTo(contentsLabel.snp.width).multipliedBy(0.5)
    }
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
