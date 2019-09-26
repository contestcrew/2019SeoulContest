//
//  TextAddView.swift
//  FirstCitizen
//
//  Created by Lee on 25/09/2019.
//  Copyright © 2019 Kira. All rights reserved.
//

import UIKit

class TextAddView: UIView {
  
  let title = UILabel()
  let textField = UITextField()
  private let guideLine = UILabel()

  override init(frame: CGRect) {
    super.init(frame: frame)
    
    configure()
    autoLayout()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func configure() {
    title.upsFontBold(ofSize: 20)
    title.textColor = .darkGray
    self.addSubview(title)
    
    textField.autocapitalizationType = .none
    self.addSubview(textField)
    
    guideLine.backgroundColor = .darkGray
    self.addSubview(guideLine)
  }
  
  private struct Standard {
    static let space: CGFloat = 8
    
  }
  
  private func autoLayout() {
    title.translatesAutoresizingMaskIntoConstraints = false
    title.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
    title.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
    
    textField.translatesAutoresizingMaskIntoConstraints = false
    textField.topAnchor.constraint(equalTo: title.bottomAnchor, constant: Standard.space).isActive = true
    textField.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
    textField.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    textField.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    
    guideLine.translatesAutoresizingMaskIntoConstraints = false
    guideLine.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
    guideLine.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    guideLine.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 4).isActive = true
    guideLine.heightAnchor.constraint(equalToConstant: 1).isActive = true
  }
}
