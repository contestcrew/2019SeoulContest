
//
//  RequestDetailView.swift
//  FirstCitizen
//
//  Created by Fury on 23/09/2019.
//  Copyright © 2019 Kira. All rights reserved.
//

import UIKit
import NMapsMap

protocol RequestDetailViewDelegate: class {
  func touchUpBackButton()
}

class RequestDetailView: UIView {
  
  weak var delegate: RequestDetailViewDelegate?
  var category: String = ""
  
  var detailRequestIncidentData: IncidentData?
  var categoryShared = CategoryDataManager.shared
  
  private var pictureDatas: [String] = []
  
  private let backButton = UIButton()
  
  let incidentTableView = UITableView()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    self.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    
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
  
  private func attribute() {
    backButton.setImage(#imageLiteral(resourceName: "Back_Button"), for: .normal)
    backButton.addTarget(self, action: #selector(touchUpBackButton), for: .touchUpInside)
    
    incidentTableView.allowsSelection = false
    incidentTableView.separatorStyle = .none
    incidentTableView.dataSource = self
    incidentTableView.delegate = self
    
    incidentTableView.register(MapCell.self, forCellReuseIdentifier: MapCell.identifier)
    incidentTableView.register(TitleCell.self, forCellReuseIdentifier: TitleCell.identifier)
    incidentTableView.register(ExtraInfomaitionCell.self, forCellReuseIdentifier: ExtraInfomaitionCell.identifier)
    incidentTableView.register(ContentsCell.self, forCellReuseIdentifier: ContentsCell.identifier)
    incidentTableView.register(RequestDetailCell.self, forCellReuseIdentifier: RequestDetailCell.identifier)
    
    if category != "똥휴지" {
      incidentTableView.register(OccurredTimeCell.self, forCellReuseIdentifier: OccurredTimeCell.identifier)
      incidentTableView.register(AttatchedFileCell.self, forCellReuseIdentifier: AttatchedFileCell.identifier)
    }
  }
  
  private func layout() {
    let margin: CGFloat = 10
    
    [incidentTableView, backButton].forEach {
      self.addSubview($0)
    }
    
    backButton.snp.makeConstraints {
      $0.top.equalTo(self.safeAreaLayoutGuide.snp.top)
      $0.leading.equalTo(self.safeAreaLayoutGuide.snp.leading).offset(margin.dynamic(1))
      $0.width.height.equalTo(margin.dynamic(3) + 5)
    }
    
    incidentTableView.snp.makeConstraints {
      $0.top.leading.trailing.bottom.equalTo(self)
    }
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension RequestDetailView: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 7
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if indexPath.row == 0 {
      let cell = tableView.dequeueReusableCell(withIdentifier: MapCell.identifier, for: indexPath) as! MapCell
      
      let pinImageUrlStr = categoryShared.categoryData[(detailRequestIncidentData?.category)! - 1].pinImage
      cell.modifyProperties(detailRequestIncidentData?.latitude, detailRequestIncidentData?.longitude, pinImageUrlStr: pinImageUrlStr)
      return cell
    } else if indexPath.row == 1 {
      let cell = tableView.dequeueReusableCell(withIdentifier: TitleCell.identifier, for: indexPath) as! TitleCell
      let urlStr = categoryShared.categoryData[(detailRequestIncidentData?.category)! - 1].image
      cell.modifyProperties(detailRequestIncidentData!.title, urlStr)
      
      return cell
    } else if indexPath.row == 2 {
      let cell = tableView.dequeueReusableCell(withIdentifier: ExtraInfomaitionCell.identifier, for: indexPath) as! ExtraInfomaitionCell
      
      let mainAddress = detailRequestIncidentData?.mainAddress ?? ""
      let detailAddress = detailRequestIncidentData?.detailAddress ?? ""
      let fullAddress = "\(mainAddress), \(detailAddress)"
      
      let point = "Point \(detailRequestIncidentData!.categoryScore) + Bonus \(detailRequestIncidentData!.score)"
      
      let uploadTime = "\(detailRequestIncidentData?.createdAt ?? "")"
      
      cell.modifyProperties(fullAddress, point, uploadTime)
      
      return cell
    } else if indexPath.row == 3 {
      let cell = tableView.dequeueReusableCell(withIdentifier: OccurredTimeCell.identifier, for: indexPath) as! OccurredTimeCell
      if category == "똥휴지" {
        cell.isHidden = true
      }
      
      let occurredTime = detailRequestIncidentData?.occurredAt ?? ""
      
      cell.modifyProperties(occurredTime)
      return cell
    } else if indexPath.row == 4 {
      let cell = tableView.dequeueReusableCell(withIdentifier: AttatchedFileCell.identifier, for: indexPath) as! AttatchedFileCell
      if category == "똥휴지" {
        cell.isHidden = true
      }
      cell.modifyProperties(imagesStr: detailRequestIncidentData!.images)
      return cell
    } else if indexPath.row == 5 {
      let cell = tableView.dequeueReusableCell(withIdentifier: ContentsCell.identifier, for: indexPath) as! ContentsCell
      cell.modifyProperties(detailRequestIncidentData!.content)
      return cell
    } else {
      let cell = tableView.dequeueReusableCell(withIdentifier: RequestDetailCell.identifier, for: indexPath) as! RequestDetailCell
      
      return cell
    }
  }
}

extension RequestDetailView: UITableViewDelegate {
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
