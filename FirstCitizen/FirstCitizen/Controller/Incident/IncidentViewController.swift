//
//  IncidentViewController.swift
//  FirstCitizen
//
//  Created by Fury on 10/09/2019.
//  Copyright © 2019 Kira. All rights reserved.
//

import UIKit

class IncidentViewController: UIViewController {
  
  private let incidentView = IncidentView()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    attribute()
    layout()
  }
  
  private func attribute() {
    
  }
  
  private func layout() {
    self.view.addSubview(incidentView)
    
    incidentView.snp.makeConstraints {
      $0.top.leading.trailing.equalToSuperview()
      $0.bottom.equalTo(self.view.safeAreaLayoutGuide)
    }
  }
}
