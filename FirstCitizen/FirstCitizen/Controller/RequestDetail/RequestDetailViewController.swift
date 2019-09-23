//
//  RequestDetailViewController.swift
//  FirstCitizen
//
//  Created by Fury on 23/09/2019.
//  Copyright © 2019 Kira. All rights reserved.
//

import UIKit

class RequestDetailViewController: UIViewController {
  
  var category: String = ""
  
  lazy private var requestDetailView = RequestDetailView(frame: .zero, category: category)
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    attribute()
    layout()
  }
  
  private func attribute() {
    self.view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    requestDetailView.category = category
  }
  
  private func layout() {
    self.view.addSubview(requestDetailView)
    
    requestDetailView.snp.makeConstraints {
      $0.top.leading.trailing.equalToSuperview()
      $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
    }
  }
}
