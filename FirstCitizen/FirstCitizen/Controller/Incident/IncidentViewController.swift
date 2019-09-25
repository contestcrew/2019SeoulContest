//
//  IncidentTestViewController.swift
//  FirstCitizen
//
//  Created by Fury on 24/09/2019.
//  Copyright © 2019 Kira. All rights reserved.
//

import UIKit

class IncidentViewController: UIViewController {
  var category: String = ""
  
  private let incidentView = IncidentView()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    
  }
  
  override func viewWillLayoutSubviews() {
    super.viewWillLayoutSubviews()
    
    attribute()
    layout()
    
  }
  
  private func attribute() {
    self.view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
  }
  
  private func layout() {
    self.view.addSubview(incidentView)
    
    let safeAreaTopInset = self.view.safeAreaInsets.top
    
    incidentView.snp.makeConstraints {
      $0.top.equalToSuperview().offset(-safeAreaTopInset)
      $0.leading.trailing.bottom.equalToSuperview()
    }
  }
}
