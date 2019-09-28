//
//  RequestDetailCell.swift
//  FirstCitizen
//
//  Created by Fury on 23/09/2019.
//  Copyright © 2019 Kira. All rights reserved.
//

import UIKit

class RequestDetailCell: UITableViewCell {
  
  static let identifier = "RequestDetailCell"
  var category: String = ""
  
  private let helpLabel = UILabel()
  private let helpUnderLineLabel = UILabel()
  private let helpListTableView = UITableView()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    attribute()
    layout()
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    
    helpListTableView.rowHeight = UITableView.automaticDimension
    helpListTableView.estimatedRowHeight = 180
  }
  
  private func attribute() {
    helpLabel.text = "도움"
    helpLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    helpLabel.dynamicFont(fontSize: 24, weight: .bold)
    
    helpUnderLineLabel.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    
//    helpListTableView.allowsSelection = false
//    helpListTableView.isScrollEnabled = false
    helpListTableView.dataSource = self
    helpListTableView.delegate = self
    
    helpListTableView.register(RequestDetailHelpCell.self, forCellReuseIdentifier: RequestDetailHelpCell.identifier)
  }
  
  private func layout() {
    let margin: CGFloat = 10
    [helpLabel, helpUnderLineLabel, helpListTableView].forEach {
      contentView.addSubview($0)
    }
    
    helpLabel.snp.makeConstraints {
      $0.top.equalTo(contentView).offset(margin.dynamic(2))
      $0.leading.equalTo(contentView).offset(margin.dynamic(2))
      $0.trailing.equalTo(contentView).offset(-margin.dynamic(2))
    }
    
    helpUnderLineLabel.snp.makeConstraints {
      $0.top.equalTo(helpLabel.snp.bottom).offset(margin.dynamic(1))
      $0.leading.equalTo(helpLabel.snp.leading)
      $0.trailing.equalTo(helpLabel.snp.trailing)
      $0.height.equalTo(margin.dynamic(0.1))
    }
    
    helpListTableView.snp.makeConstraints {
      $0.top.equalTo(helpUnderLineLabel.snp.bottom).offset(margin.dynamic(1))
      $0.leading.trailing.bottom.equalToSuperview()
//      $0.height.equalTo(500)
    }
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension RequestDetailCell: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 5
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: RequestDetailHelpCell.identifier, for: indexPath) as! RequestDetailHelpCell
    return cell
  }
}

extension RequestDetailCell: UITableViewDelegate {
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

    return UITableView.automaticDimension
  }
}
