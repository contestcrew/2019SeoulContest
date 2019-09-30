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
  let reportShared = ReportDataManager.shared
  
  var category = ""
  var isAcceptOneThins: Bool = false
  
  private let nicknameLabel = UILabel()
  private let reliabilityLabel = UILabel()
  private let attachFileCountLabel = UILabel()
  
  private let acceptButton = UIButton()
  private let denyButton = UIButton()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    category = reportShared.reportCategory
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
  
  @objc private func touchUpAcceptButton(_ sender: UIButton) {
    if reportShared.isAcceptOneThings {
      if sender.titleLabel?.text == "완료" {
        acceptButton.setTitleColor(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1), for: .normal)
        denyButton.isHidden = true
      } else if sender.titleLabel?.text == "거부" {
        acceptButton.setTitle("수락", for: .normal)
        acceptButton.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
        denyButton.isHidden = true
        reportShared.isAcceptOneThings = false
      }
    } else {
      if sender.titleLabel?.text == "수락" {
        acceptButton.setTitle("완료", for: .normal)
        acceptButton.setTitleColor(#colorLiteral(red: 0, green: 0.01932368055, blue: 1, alpha: 1), for: .normal)
        denyButton.isHidden = false
        reportShared.isAcceptOneThings = true
        
        NetworkService.updateRequestHelpData(requestID: reportShared.relatedRequestIdx, incidentData: reportShared.relatedRequestData!)
        
      } else {
        acceptButton.setTitle("수락", for: .normal)
        acceptButton.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
        denyButton.isHidden = true
      }
    }
    
  }
  
  @objc private func touchUpDenyButton() {
    
  }
  
  @objc private func touchUpShowButton() {
    
  }
  
  func cellModify(reliablity: Int, reportData: ReportData) {
    nicknameLabel.text = "\(reportData.author.nickname)"
        reliabilityLabel.text = "신뢰도 : \(reliablity)"
    
    if category == "똥휴지" {
      
    } else {
      attachFileCountLabel.text = "첨부파일 : \(reportData.images!.count)"
    }
  }
  
  private func attribute() {
    nicknameLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    nicknameLabel.dynamicFont(fontSize: 18, weight: .medium)
    nicknameLabel.textAlignment = .left
    
    reliabilityLabel.text = "신뢰도 : 100"
    reliabilityLabel.dynamicFont(fontSize: 18, weight: .medium)
    reliabilityLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    reliabilityLabel.textAlignment = .left
    
    attachFileCountLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    attachFileCountLabel.textAlignment = .center
    attachFileCountLabel.dynamicFont(fontSize: 20, weight: .heavy)
    
    if category == "똥휴지" {
      acceptButton.setTitle("수락", for: .normal)
      acceptButton.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
      acceptButton.titleLabel?.dynamicFont(fontSize: 20, weight: .heavy)
      acceptButton.addTarget(self, action: #selector(touchUpAcceptButton(_:)), for: .touchUpInside)
      
      denyButton.setTitle("거부", for: .normal)
      denyButton.setTitleColor(#colorLiteral(red: 1, green: 0, blue: 0, alpha: 1), for: .normal)
      denyButton.titleLabel?.dynamicFont(fontSize: 20, weight: .heavy)
      denyButton.addTarget(self, action: #selector(touchUpAcceptButton(_:)), for: .touchUpInside)
      denyButton.isHidden = true
    } else {
      acceptButton.setImage(#imageLiteral(resourceName: "arrow"), for: .normal)
      acceptButton.contentMode = .scaleAspectFit
      acceptButton.titleLabel?.dynamicFont(fontSize: 14, weight: .medium)
      acceptButton.addTarget(self, action: #selector(touchUpShowButton), for: .touchUpInside)
    }
  }
  
  private func layout() {
    let margin: CGFloat = 10
    
    [nicknameLabel, reliabilityLabel, acceptButton].forEach { contentView.addSubview($0) }
    
    nicknameLabel.snp.makeConstraints {
      $0.top.leading.equalToSuperview().offset(margin.dynamic(1))
      $0.height.equalTo(margin.dynamic(5))
    }
    
    reliabilityLabel.snp.makeConstraints {
      $0.top.equalTo(nicknameLabel.snp.bottom).offset(margin.dynamic(1))
      $0.leading.equalToSuperview().offset(margin.dynamic(1))
      $0.bottom.equalToSuperview().offset(-margin.dynamic(1))
      $0.height.equalTo(nicknameLabel.snp.height)
    }
    
    acceptButton.snp.makeConstraints {
      $0.top.bottom.equalToSuperview()
      $0.trailing.equalTo(contentView).offset(-margin.dynamic(1))
    }
    
    if category == "똥휴지" {
      contentView.addSubview(denyButton)
      
      denyButton.snp.makeConstraints {
        $0.top.bottom.equalToSuperview()
        $0.trailing.equalTo(acceptButton.snp.leading).offset(-margin.dynamic(1))
      }
      
    } else {
      contentView.addSubview(attachFileCountLabel)
      
      attachFileCountLabel.snp.makeConstraints {
        $0.top.equalTo(nicknameLabel.snp.bottom).offset(margin.dynamic(1))
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
