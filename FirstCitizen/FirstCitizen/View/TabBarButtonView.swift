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
    self.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
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
      $0.trailing.equalTo(mapListButton.snp.leading).offset(-Standard.sideSpace.dynamic(3))
      $0.width.height.equalTo(Standard.sideSize.dynamic(1) - 10)
    }

    mapListButton.snp.makeConstraints {
      $0.centerX.top.bottom.equalTo(self)
      $0.width.height.equalTo(Standard.centerSize.dynamic(1))
    }

    settingButton.snp.makeConstraints {
      $0.centerY.equalTo(self)
      $0.leading.equalTo(mapListButton.snp.trailing).offset(Standard.sideSpace.dynamic(3))
      $0.width.height.equalTo(Standard.sideSize.dynamic(1) - 10)
    }
  }
}
