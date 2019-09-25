//
//  RequestCreateAddressCell.swift
//  FirstCitizen
//
//  Created by Lee on 25/09/2019.
//  Copyright © 2019 Kira. All rights reserved.
//

import UIKit

enum AddressType {
  case map
  case text
}

class RequestCreateAddressCell: UITableViewCell {

  static let identifier = "RequestCreateAddressCell"
  
  private let base = UIView()
  private let title = UILabel()
  private let imageV = UIImageView()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    configure()
    autoLayout()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func setting(type: AddressType) {
    switch type {
    case .map:
      title.text = "지도로 찾기"
      imageV.image = UIImage(named: "location")
      
    case .text:
      title.text = "주소로 찾기"
      imageV.image = UIImage(named: "search")
    }
  }
  
  private func configure() {
    self.selectionStyle = .none
    
    base.layer.cornerRadius = 8
    base.backgroundColor = .white
    base.shadow()
    contentView.addSubview(base)
    
    title.upsFontHeavy(ofSize: 20)
    contentView.addSubview(title)
    
    imageV.contentMode = .scaleAspectFit
    contentView.addSubview(imageV)
  }
  
  private struct Standard {
    static let space: CGFloat = 8
    static let xSpace: CGFloat = 24
    static let ySpace: CGFloat = 8
    
    static let imageSize: CGFloat = 32
  }
  
  private func autoLayout() {
    base.translatesAutoresizingMaskIntoConstraints = false
    base.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Standard.ySpace).isActive = true
    base.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Standard.xSpace).isActive = true
    base.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Standard.xSpace).isActive = true
    base.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Standard.ySpace).isActive = true
    
    title.translatesAutoresizingMaskIntoConstraints = false
    title.centerYAnchor.constraint(equalTo: base.centerYAnchor).isActive = true
    title.leadingAnchor.constraint(equalTo: base.leadingAnchor, constant: Standard.xSpace).isActive = true
    
    imageV.translatesAutoresizingMaskIntoConstraints = false
    imageV.topAnchor.constraint(equalTo: base.topAnchor, constant: Standard.ySpace).isActive = true
    imageV.trailingAnchor.constraint(equalTo: base.trailingAnchor, constant: -Standard.xSpace).isActive = true
    imageV.bottomAnchor.constraint(equalTo: base.bottomAnchor, constant: -Standard.ySpace).isActive = true
    imageV.widthAnchor.constraint(equalToConstant: Standard.imageSize).isActive = true
    imageV.heightAnchor.constraint(equalToConstant: Standard.imageSize).isActive = true
  }
}
