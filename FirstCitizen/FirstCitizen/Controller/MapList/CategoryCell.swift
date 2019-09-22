//
//  CategoryCell.swift
//  FirstCitizen
//
//  Created by Fury on 22/09/2019.
//  Copyright © 2019 Kira. All rights reserved.
//

import UIKit

class CategoryCell: UICollectionViewCell {
  
  static let identifier = "CategoryCell"
  
  let categoryName = UILabel()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    attribute()
    layout()
  }
  
  func cellConfigure(_ categoryName: String) {
    self.categoryName.text = categoryName
  }
  
  private func attribute() {
    categoryName.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    categoryName.upsFont(ofSize: 22)
    categoryName.textAlignment = .center
  }
  
  private func layout() {
    contentView.addSubview(categoryName)
    categoryName.snp.makeConstraints {
      $0.top.trailing.bottom.equalToSuperview()
      $0.leading.equalToSuperview().offset(10)
    }
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
