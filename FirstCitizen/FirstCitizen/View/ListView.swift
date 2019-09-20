//
//  ListView.swift
//  FirstCitizen
//
//  Created by Fury on 20/09/2019.
//  Copyright © 2019 Kira. All rights reserved.
//

import UIKit

class ListView: UIView {
  
  private let searchBar = UISearchBar()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    attribute()
    layout()
  }
  
  private func attribute() {
    self.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    searchBar.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
  }
  
  private func layout() {
    [searchBar].forEach { self.addSubview($0) }
    
    searchBar.snp.makeConstraints {
      $0.top.leading.equalToSuperview().offset(10)
      $0.trailing.equalToSuperview().offset(-10)
      $0.width.equalTo(50)
    }
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
