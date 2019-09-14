//
//  SettingGuideView.swift
//  FirstCitizen
//
//  Created by Lee on 11/09/2019.
//  Copyright © 2019 Kira. All rights reserved.
//

import UIKit

class SettingGuideLineView: UIView {
  
  let line = UILabel()
  let title = UILabel()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    configure()
    autoLayout()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func configure() {
    line.backgroundColor = .gray
    self.addSubview(line)
    
    title.textColor = .gray
    title.backgroundColor = .white
    self.addSubview(title)
  }
  
  private func autoLayout() {
    line.translatesAutoresizingMaskIntoConstraints = false
    line.centerYAnchor.constraint(equalTo: title.centerYAnchor).isActive = true
    line.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
    line.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    line.heightAnchor.constraint(equalToConstant: 0.7).isActive = true
    
    title.translatesAutoresizingMaskIntoConstraints = false
    title.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
    title.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
    title.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
  }
}
