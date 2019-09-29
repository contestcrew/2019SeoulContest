//
//  IncidentView.swift
//  FirstCitizen
//
//  Created by Fury on 24/09/2019.
//  Copyright © 2019 Kira. All rights reserved.
//

import UIKit
import Kingfisher

protocol IncidentViewDelegate: class {
  func touchUpBackButton()
  func touchUpHelpButton(category: String)
}

class IncidentView: UIView {
  
  var category: String = ""
  weak var delegate: IncidentViewDelegate!
  
  var detailIncidentData: IncidentData?
  var categoryShared = CategoryDataManager.shared
  
  private let backButton = UIButton(type: .custom)
  private let helpButton = UIButton(type: .custom)
  
  private let incidentTableView = UITableView()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    attribute()
    layout()
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    
    incidentTableView.rowHeight = UITableView.automaticDimension
    incidentTableView.estimatedRowHeight = 180
  }
  
  @objc private func touchUpBackButton() {
    delegate?.touchUpBackButton()
  }
  
  @objc private func touchUpHelpButton() {
    delegate?.touchUpHelpButton(category: category)
  }
  
  private func attribute() {
    backButton.setImage(#imageLiteral(resourceName: "Back_Button"), for: .normal)
    backButton.addTarget(self, action: #selector(touchUpBackButton), for: .touchUpInside)
    
    helpButton.setTitle("도와주기", for: .normal)
    helpButton.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
    helpButton.titleLabel?.dynamicFont(fontSize: 26, weight: .bold)
    helpButton.layer.cornerRadius = 10
    helpButton.backgroundColor = UIColor.appColor(.appButtonColor)
    helpButton.addTarget(self, action: #selector(touchUpHelpButton), for: .touchUpInside)
    
    incidentTableView.allowsSelection = false
    incidentTableView.separatorStyle = .none
    incidentTableView.dataSource = self
    incidentTableView.delegate = self
    
    incidentTableView.register(MapCell.self, forCellReuseIdentifier: MapCell.identifier)
    incidentTableView.register(TitleCell.self, forCellReuseIdentifier: TitleCell.identifier)
    incidentTableView.register(ExtraInfomaitionCell.self, forCellReuseIdentifier: ExtraInfomaitionCell.identifier)
    incidentTableView.register(ContentsCell.self, forCellReuseIdentifier: ContentsCell.identifier)
    
    if category != "똥휴지" {
      incidentTableView.register(OccurredTimeCell.self, forCellReuseIdentifier: OccurredTimeCell.identifier)
      incidentTableView.register(AttatchedFileCell.self, forCellReuseIdentifier: AttatchedFileCell.identifier)
    }
  }
  
  private func layout() {
    let margin: CGFloat = 10
    
    [incidentTableView, backButton, helpButton].forEach {
      self.addSubview($0)
    }
    
    backButton.snp.makeConstraints {
      $0.top.equalTo(self.safeAreaLayoutGuide.snp.top)
      $0.leading.equalTo(self.safeAreaLayoutGuide.snp.leading).offset(margin.dynamic(1))
      $0.width.height.equalTo(margin.dynamic(3) + 5)
    }
    
    helpButton.snp.makeConstraints {
      $0.leading.equalTo(self).offset(margin.dynamic(2))
      $0.trailing.equalTo(self).offset(-margin.dynamic(2))
      $0.bottom.equalTo(self).offset(-margin.dynamic(2))
      $0.height.equalTo(margin.dynamic(5))
    }
    
    incidentTableView.snp.makeConstraints {
      $0.top.leading.trailing.equalTo(self)
      $0.bottom.equalTo(helpButton.snp.top).offset(-margin.dynamic(1))
    }
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension IncidentView: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 6
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if indexPath.row == 0 {
      let cell = tableView.dequeueReusableCell(withIdentifier: MapCell.identifier, for: indexPath) as! MapCell
      
      let pinImageUrlStr = categoryShared.categoryData[(detailIncidentData?.category)! - 1].pinImage
      cell.modifyProperties(detailIncidentData!.latitude, detailIncidentData!.longitude, pinImageUrlStr: pinImageUrlStr)
      return cell
    } else if indexPath.row == 1 {
      let cell = tableView.dequeueReusableCell(withIdentifier: TitleCell.identifier, for: indexPath) as! TitleCell
      let urlStr = categoryShared.categoryData[(detailIncidentData?.category)! - 1].image
      cell.modifyProperties(detailIncidentData!.title, urlStr)
      
      return cell
    } else if indexPath.row == 2 {
      let cell = tableView.dequeueReusableCell(withIdentifier: ExtraInfomaitionCell.identifier, for: indexPath) as! ExtraInfomaitionCell
      
      let mainAddress = detailIncidentData?.mainAddress ?? ""
      let detailAddress = detailIncidentData?.detailAddress ?? ""
      let fullAddress = "\(mainAddress), \(detailAddress)"
      
      let point = "Point \(detailIncidentData!.categoryScore) + Bonus \(detailIncidentData!.score)"
      
      let uploadTime = "\(detailIncidentData?.createdAt ?? "")"
      
      cell.modifyProperties(fullAddress, point, uploadTime)
      
      return cell
    } else if indexPath.row == 3 {
      let cell = tableView.dequeueReusableCell(withIdentifier: OccurredTimeCell.identifier, for: indexPath) as! OccurredTimeCell
      if category == "똥휴지" {
        cell.isHidden = true
      } else {
        cell.modifyProperties(detailIncidentData!.occurredAt!)
      }
      return cell
    } else if indexPath.row == 4 {
      let cell = tableView.dequeueReusableCell(withIdentifier: AttatchedFileCell.identifier, for: indexPath) as! AttatchedFileCell
      if category == "똥휴지" {
        cell.isHidden = true
      } else {
        cell.modifyProperties(imagesStr: detailIncidentData!.images)
      }
      return cell
    } else {
      let cell = tableView.dequeueReusableCell(withIdentifier: ContentsCell.identifier, for: indexPath) as! ContentsCell
      cell.modifyProperties(detailIncidentData!.content)
      return cell
    }
  }
}

extension IncidentView: UITableViewDelegate {
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    if category == "똥휴지" {
      if indexPath.row == 3 || indexPath.row == 4 {
        return 0
      }
    }
    
    return UITableView.automaticDimension
  }
  
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    if scrollView.bounds.minY < 0 {
      scrollView.contentOffset.y = 0
    }
    
    let heightHarf = (UIScreen.main.bounds.height / 3)
    
    if scrollView.bounds.minY < heightHarf {
      backButton.isHidden = false
    } else {
      backButton.isHidden = true
    }
  }
}
