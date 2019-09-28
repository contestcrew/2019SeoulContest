//
//  PointCouponCell.swift
//  FirstCitizen
//
//  Created by Lee on 28/09/2019.
//  Copyright © 2019 Kira. All rights reserved.
//

import UIKit

class PointCouponCell: UITableViewCell {

  static let identifier = "PointCouponCell"
  
  private let imageV = UIImageView()
  private let display1 = UILabel()
  private let display2 = UILabel()
  let button = UIButton()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    configure()
    autoLayout()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func setting(imageName: String) {
    imageV.image = UIImage(named: imageName)
  }
  
  private func configure() {
    self.selectionStyle = .none
    
    imageV.layer.cornerRadius = 8
    imageV.layer.masksToBounds = true
    imageV.contentMode = .scaleToFill
    contentView.addSubview(imageV)
    
    display1.text = "입장료 500원 할인"
    display1.upsFontBold(ofSize: 18)
    contentView.addSubview(display1)
    
    display2.text = "1500 포인트 차감"
    display2.textColor = .darkGray
    display2.upsFont(ofSize: 15)
    contentView.addSubview(display2)
    
    button.setTitle(" 쿠폰발급 ", for: .normal)
    button.setTitleColor(.white, for: .normal)
    button.backgroundColor = .darkGray
    button.layer.cornerRadius = 8
    button.layer.masksToBounds = true
    contentView.addSubview(button)
  }
  
  private struct Standard {
    static let space: CGFloat = 8
  }
  
  private func autoLayout() {
    imageV.translatesAutoresizingMaskIntoConstraints = false
    imageV.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8).isActive = true
    imageV.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24).isActive = true
    imageV.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8).isActive = true
    imageV.widthAnchor.constraint(equalToConstant: 64).isActive = true
    imageV.heightAnchor.constraint(equalToConstant: 64).isActive = true
    
    display1.translatesAutoresizingMaskIntoConstraints = false
    display1.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
    display1.bottomAnchor.constraint(equalTo: imageV.centerYAnchor, constant: -2).isActive = true
    
    display2.translatesAutoresizingMaskIntoConstraints = false
    display2.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
    display2.topAnchor.constraint(equalTo: imageV.centerYAnchor, constant: 2).isActive = true
    
    button.translatesAutoresizingMaskIntoConstraints = false
    button.centerYAnchor.constraint(equalTo: imageV.centerYAnchor).isActive = true
    button.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16).isActive = true
    
  }

}
