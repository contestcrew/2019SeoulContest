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
  private let helpUnderLineView = UIView()
  private let helpListTableView = UITableView()
  
  
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    
    attribute()
    layout()
  }
  
  private func attribute() {
    helpLabel.text = "내용"
    helpLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    helpLabel.dynamicFont(fontSize: 24, weight: .bold)
    
    helpUnderLineView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    
    helpListTableView.allowsSelection = false
    //    helpListTableView.isScrollEnabled = false
    helpListTableView.dataSource = self
    helpListTableView.delegate = self
    
    helpListTableView.register(RequestDetailCell.self, forCellReuseIdentifier: RequestDetailCell.identifier)
  }
  
  private func layout() {
    let margin: CGFloat = 10
    
    self.addSubview(helpListTableView)
    
    helpListTableView.snp.makeConstraints {
      $0.top.equalTo(self)
      $0.leading.trailing.equalTo(self)
      $0.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom).offset(-margin.dynamic(1))
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
    let cell = tableView.dequeueReusableCell(withIdentifier: RequestDetailCell.identifier, for: indexPath) as! RequestDetailCell
    return cell
  }
}

extension RequestDetailCell: UITableViewDelegate {
  
}
