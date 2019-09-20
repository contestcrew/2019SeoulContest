//
//  TabBarButtonView.swift
//  FirstCitizen
//
//  Created by Lee on 20/08/2019.
//  Copyright © 2019 Kira. All rights reserved.
//

import UIKit
import SnapKit

class TabBarButtonView: UIView {
  
  let pointButton = UIButton()
  let mapListButton = UIButton()
  let settingButton = UIButton()
  
  static var height: CGFloat = 0
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    configure()
    autoLayout()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    
    TabBarButtonView.height = self.frame.height
  }
  
  private func configure() {
    pointButton.setImage(UIImage(named: "TabBarPoint"), for: .normal)
    
    mapListButton.setImage(UIImage(named: "TabBarMap"), for: .normal)
    
    settingButton.setImage(UIImage(named: "TabBarSetting"), for: .normal)
  }
  
  private struct Standard {
    static let space: CGFloat = 8
    static let sideSpace: CGFloat = 8
    
    static let centerSize: CGFloat = 72
    static let sideSize: CGFloat = 54
  }
  
  private func autoLayout() {
    
    [pointButton, mapListButton, settingButton].forEach { self.addSubview($0) }
    
    pointButton.snp.makeConstraints {
      $0.centerY.equalTo(self.snp.centerY)
      $0.trailing.equalTo(mapListButton.snp.leading).offset(-Standard.sideSpace * 3)
      $0.width.height.equalTo(Standard.sideSize - 10)
    }

    mapListButton.snp.makeConstraints {
      $0.centerX.top.bottom.equalTo(self)
      $0.width.height.equalTo(Standard.centerSize)
    }

    settingButton.snp.makeConstraints {
      $0.centerY.equalTo(self)
      $0.leading.equalTo(mapListButton.snp.trailing).offset(Standard.sideSpace * 3)
      $0.width.height.equalTo(Standard.sideSize - 10)
    }
    
//    pointButton.translatesAutoresizingMaskIntoConstraints = false
//    pointButton.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
////    pointButton.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
//    pointButton.trailingAnchor.constraint(equalTo: mapListButton.leadingAnchor, constant: -Standard.sideSpace).isActive = true
//    pointButton.widthAnchor.constraint(equalToConstant: Standard.sideSize).isActive = true
//    pointButton.heightAnchor.constraint(equalToConstant: Standard.sideSize).isActive = true
//
//    mapListButton.translatesAutoresizingMaskIntoConstraints = false
//    mapListButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
////    mapListButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
//    mapListButton.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
//    mapListButton.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
//    mapListButton.widthAnchor.constraint(equalToConstant: Standard.centerSize).isActive = true
//    mapListButton.heightAnchor.constraint(equalToConstant: Standard.centerSize).isActive = true
//
//    settingButton.translatesAutoresizingMaskIntoConstraints = false
//    settingButton.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
////    settingButton.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
//    settingButton.leadingAnchor.constraint(equalTo: mapListButton.trailingAnchor, constant: Standard.sideSpace).isActive = true
//    settingButton.widthAnchor.constraint(equalToConstant: Standard.sideSize).isActive = true
//    settingButton.heightAnchor.constraint(equalToConstant: Standard.sideSize).isActive = true
  }
}
