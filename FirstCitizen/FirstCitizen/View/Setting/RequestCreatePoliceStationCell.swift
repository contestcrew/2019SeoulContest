//
//  RequestCreatePoliceStationCell.swift
//  FirstCitizen
//
//  Created by Lee on 25/09/2019.
//  Copyright © 2019 Kira. All rights reserved.
//

import UIKit

class RequestCreatePoliceStationCell: UITableViewCell {

  static let identifier = "RequestCreatePoliceStationCell"
  
  let picker = UIPickerView()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    configure()
    autoLayout()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func configure() {
    self.selectionStyle = .none
    
    contentView.addSubview(picker)
  }
  
  private struct Standard {
    static let space: CGFloat = 8
  }
  
  private func autoLayout() {
    picker.translatesAutoresizingMaskIntoConstraints = false
    picker.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
    picker.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
    picker.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
    picker.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    picker.heightAnchor.constraint(equalToConstant: 120).isActive = true
  }
}

