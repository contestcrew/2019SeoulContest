
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
  private let categoryShared = CategoryDataManager.shared
  
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
    contentView.layer.borderColor = UIColor.appColor(.appLayerBorderColor).cgColor
    contentView.layer.borderWidth = 2
    contentView.layer.cornerRadius = 10
    
    contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0))
    contentView.layoutIfNeeded()
  }
  
  func changePreviewContainer(_ homeIncidentData: IncidentData) {
    titleLabel.text = homeIncidentData.title
    let iconImgUrlStr: String = categoryShared.categoryData[homeIncidentData.category - 1].image
    let iconImgURL: URL = URL(string: iconImgUrlStr)!
    iconImage.kf.setImage(with: iconImgURL)
    
    guard let createdTime = homeIncidentData.createdAt else { return }
    let date = Date()
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
    let time = date.convertDateFormatter(date: createdTime)
    let dateTime = dateFormatter.date(from: time)
    let daysBetweenDate = date.daysBetweenDate(toDate: dateTime!)
    dateLabel.text = daysBetweenDate
    
    contentsLabel.text = homeIncidentData.content
    pointLabel.text = "Point \(homeIncidentData.categoryScore) + Bonus \(homeIncidentData.score)"
    let attributedStr = NSMutableAttributedString(string: pointLabel.text!)
    attributedStr.addAttribute(.foregroundColor, value: UIColor.blue, range: (pointLabel.text! as NSString).range(of: "Bonus"))
    attributedStr.addAttribute(.foregroundColor, value: UIColor.orange, range: (pointLabel.text! as NSString).range(of: "Point"))
    pointLabel.attributedText = attributedStr
  }
  
  private func attribute() {
    iconImage.contentMode = .scaleAspectFit
    
    titleLabel.text = "굳어가고 있어요 헬프미"
    titleLabel.dynamicFont(fontSize: 26, weight: .heavy)
    
    guideLabel.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    
    dateLabel.text = "2019-08-14 목요일"
    dateLabel.dynamicFont(fontSize: 13, weight: .semibold)
    
    pointLabel.text = "Point 100 + Bonus 350"
    pointLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    pointLabel.textAlignment = .right
    pointLabel.dynamicFont(fontSize: 13, weight: .semibold)
    let attributedStr = NSMutableAttributedString(string: pointLabel.text!)
    attributedStr.addAttribute(.foregroundColor, value: UIColor.blue, range: (pointLabel.text! as NSString).range(of: "Bonus"))
    attributedStr.addAttribute(.foregroundColor, value: UIColor.orange, range: (pointLabel.text! as NSString).range(of: "Point"))
    pointLabel.attributedText = attributedStr
    
    contentsLabel.text = "굳어가고 있어요.. 헬퓨ㅡ미.."
    contentsLabel.textColor = .darkGray
    contentsLabel.dynamicFont(fontSize: 15, weight: .bold)
    
    progressLabel.text = "도움요청중"
    progressLabel.textAlignment = .center
    progressLabel.textColor = #colorLiteral(red: 0.03933401406, green: 0.7532997727, blue: 0.2689341307, alpha: 1)
    progressLabel.dynamicFont(fontSize: 22, weight: .heavy)
  }
  
  private func layout() {
    let margin: CGFloat = 10
    
    [titleLabel, iconImage, guideLabel, dateLabel, pointLabel, contentsLabel, progressLabel]
      .forEach { contentView.addSubview($0) }
    
    titleLabel.snp.makeConstraints {
      $0.top.equalToSuperview().offset(margin.dynamic(2))
      $0.leading.equalToSuperview().offset(margin.dynamic(1))
    }
    
    iconImage.snp.makeConstraints {
      $0.centerY.equalTo(titleLabel.snp.centerY)
      $0.trailing.equalToSuperview().offset(-margin.dynamic(1))
      $0.width.height.equalTo(margin.dynamic(4))
    }
    
    guideLabel.snp.makeConstraints {
      $0.top.equalTo(titleLabel.snp.bottom).offset(margin.dynamic(2))
      $0.leading.equalToSuperview().offset(margin.dynamic(1))
      $0.trailing.equalToSuperview().offset(-margin.dynamic(1))
      $0.height.equalTo(margin.dynamic(0.2))
    }
    
    dateLabel.snp.makeConstraints {
      $0.top.equalTo(guideLabel.snp.bottom).offset(margin.dynamic(1))
      $0.leading.equalToSuperview().offset(margin.dynamic(1))
    }
    
    pointLabel.snp.makeConstraints {
      $0.top.equalTo(guideLabel.snp.bottom).offset(margin.dynamic(1))
      $0.leading.equalTo(dateLabel.snp.trailing)
      $0.trailing.equalToSuperview().offset(-margin.dynamic(1))
      $0.width.equalTo(dateLabel.snp.width)
    }
    
    contentsLabel.snp.makeConstraints {
      $0.top.equalTo(dateLabel.snp.bottom).offset(margin.dynamic(2))
      $0.leading.equalToSuperview().offset(margin.dynamic(1))
      $0.bottom.equalToSuperview().offset(-margin.dynamic(2))
    }
    
    progressLabel.snp.makeConstraints {
      $0.leading.equalTo(contentsLabel.snp.trailing)
      $0.centerY.equalTo(contentsLabel.snp.centerY)
      $0.trailing.equalToSuperview().offset(-margin.dynamic(2))
      $0.width.equalTo(contentsLabel.snp.width).multipliedBy(0.5)
    }
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
