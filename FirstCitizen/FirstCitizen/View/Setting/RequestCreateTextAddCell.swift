//
//  RequestCreateTextAddCell.swift
//  FirstCitizen
//
//  Created by Lee on 25/09/2019.
//  Copyright © 2019 Kira. All rights reserved.
//

import UIKit

enum TextViewType {
  case field
  case view
}

class RequestCreateTextAddCell: UITableViewCell {

  static let identifier = "RequestCreateTextAddCell"
  
  private let base = UIView()
  let textField = UITextField()
  let textView = UITextView()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    configure()
    autoLayout()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func setting(type: TextViewType) {
    switch type {
    case .field:
      contentView.addSubview(textField)
      
      textField.translatesAutoresizingMaskIntoConstraints = false
      textField.topAnchor.constraint(equalTo: base.topAnchor, constant: Standard.space).isActive = true
      textField.leadingAnchor.constraint(equalTo: base.leadingAnchor, constant: Standard.space).isActive = true
      textField.trailingAnchor.constraint(equalTo: base.trailingAnchor, constant: -Standard.space).isActive = true
      textField.bottomAnchor.constraint(equalTo: base.bottomAnchor, constant: -Standard.space).isActive = true
      textField.heightAnchor.constraint(equalToConstant: 24).isActive = true
      
    case .view:
      contentView.addSubview(textView)
      
      textView.translatesAutoresizingMaskIntoConstraints = false
      textView.topAnchor.constraint(equalTo: base.topAnchor, constant: Standard.space).isActive = true
      textView.leadingAnchor.constraint(equalTo: base.leadingAnchor, constant: Standard.space).isActive = true
      textView.trailingAnchor.constraint(equalTo: base.trailingAnchor, constant: -Standard.space).isActive = true
      textView.bottomAnchor.constraint(equalTo: base.bottomAnchor, constant: -Standard.space).isActive = true
      textView.heightAnchor.constraint(equalToConstant: 120).isActive = true
    }
  }
  
  private func configure() {
    self.selectionStyle = .none
    
    base.layer.cornerRadius = 8
    base.backgroundColor = .white
    base.shadow()
    contentView.addSubview(base)
  }
  
  private struct Standard {
    static let space: CGFloat = 8
    static let xSpace: CGFloat = 24
    static let ySpace: CGFloat = 8
  }
  
  private func autoLayout() {
    base.translatesAutoresizingMaskIntoConstraints = false
    base.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Standard.ySpace).isActive = true
    base.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Standard.xSpace).isActive = true
    base.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Standard.xSpace).isActive = true
    base.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Standard.ySpace).isActive = true
  }
}
