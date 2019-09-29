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
  
  // 기존 기획대로는 detailIncident 받아와야하는데 기존에 다 가져와버림. 분리 예정
  var detailIncidentData: IncidentData?
  
  private let incidentView = IncidentView()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
  }
  
  override func viewWillLayoutSubviews() {
    super.viewWillLayoutSubviews()
    
    incidentView.category = category
    incidentView.detailIncidentData = detailIncidentData
    attribute()
    layout()
  }
  
  private func attribute() {
    incidentView.delegate = self
    self.view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
  }
  
  private func layout() {
    self.view.addSubview(incidentView)

    incidentView.snp.makeConstraints {
      $0.top.leading.trailing.bottom.equalToSuperview()
    }
  }
}

extension IncidentViewController: IncidentViewDelegate {
  func touchUpHelpButton(category: String) {
    if category == "똥휴지" {
      UIAlertController.restroomShow(
        title: "알림",
        message: "10분 이내 도움이 가능하신 경우 돕기 버튼을 선택해주시기 바랍니다.",
        requsetID: detailIncidentData?.id ?? 0,
        from: self
      )
    } else {
      let reportVC = ReportViewController()
      reportVC.detailIncidentData = detailIncidentData
      self.present(reportVC, animated: true, completion: nil)
    }
  }
  
  func touchUpBackButton() {
    self.dismiss(animated: true, completion: nil)
  }
}
