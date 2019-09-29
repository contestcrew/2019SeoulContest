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
  
  // test
  var testShared = IncidentDataManager.shared
  
  var requestDetailData: IncidentData?
  
  private var requestDetailView = RequestDetailView()
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    requestDetailView.detailRequestIncidentData = requestDetailData
    attribute()
    layout()
  }
  
  private func attribute() {
    self.view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    requestDetailView.category = category
    
    requestDetailView.delegate = self
  }
  
  private func layout() {
    self.view.addSubview(requestDetailView)
    
    requestDetailView.snp.makeConstraints {
      $0.top.leading.trailing.bottom.equalToSuperview()
    }
  }
}

extension RequestDetailViewController: RequestDetailViewDelegate {
  func touchUpBackButton() {
    self.dismiss(animated: true, completion: nil)
  }
}
