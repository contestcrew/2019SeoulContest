//
//  IncidentView.swift
//  FirstCitizen
//
//  Created by Fury on 24/09/2019.
//  Copyright © 2019 Kira. All rights reserved.
//

import UIKit

class IncidentView: UIView {
  
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
  
  private func attribute() {
    
    incidentTableView.allowsSelection = false
    incidentTableView.separatorStyle = .none
    incidentTableView.dataSource = self
    incidentTableView.delegate = self
    
    incidentTableView.register(MapCell.self, forCellReuseIdentifier: MapCell.identifier)
    incidentTableView.register(TitleCell.self, forCellReuseIdentifier: TitleCell.identifier)
    incidentTableView.register(ExtraInfomaitionCell.self, forCellReuseIdentifier: ExtraInfomaitionCell.identifier)
    incidentTableView.register(OccurredTimeCell.self, forCellReuseIdentifier: OccurredTimeCell.identifier)
    incidentTableView.register(AttatchedFileCell.self, forCellReuseIdentifier: AttatchedFileCell.identifier)
    incidentTableView.register(ContentsCell.self, forCellReuseIdentifier: ContentsCell.identifier)
  }
  
  private func layout() {
    self.addSubview(incidentTableView)
    incidentTableView.snp.makeConstraints {
      $0.top.leading.trailing.bottom.equalTo(self)
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
      return cell
    } else if indexPath.row == 1 {
      let cell = tableView.dequeueReusableCell(withIdentifier: TitleCell.identifier, for: indexPath) as! TitleCell
      return cell
    } else if indexPath.row == 2 {
      let cell = tableView.dequeueReusableCell(withIdentifier: ExtraInfomaitionCell.identifier, for: indexPath) as! ExtraInfomaitionCell
      return cell
    } else if indexPath.row == 3 {
      let cell = tableView.dequeueReusableCell(withIdentifier: OccurredTimeCell.identifier, for: indexPath) as! OccurredTimeCell
      return cell
    } else if indexPath.row == 4 {
      let cell = tableView.dequeueReusableCell(withIdentifier: AttatchedFileCell.identifier, for: indexPath) as! AttatchedFileCell
      return cell
    } else {
      let cell = tableView.dequeueReusableCell(withIdentifier: ContentsCell.identifier, for: indexPath) as! ContentsCell
      return cell
    }
  }
}

extension IncidentView: UITableViewDelegate {
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return UITableView.automaticDimension
  }
}
