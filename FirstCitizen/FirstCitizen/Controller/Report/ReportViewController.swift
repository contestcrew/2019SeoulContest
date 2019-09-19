//
//  ReportViewController.swift
//  FirstCitizen
//
//  Created by Fury on 19/09/2019.
//  Copyright © 2019 Kira. All rights reserved.
//

import UIKit

class ReportViewController: UIViewController {
  
  private let reportView = ReportView()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    attribute()
    layout()
  }
  
  private func attribute() {
    self.view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
  }
  
  private func layout() {
    self.view.addSubview(reportView)
    
    reportView.snp.makeConstraints {
      $0.top.leading.trailing.bottom.equalToSuperview()
    }
  }
}
