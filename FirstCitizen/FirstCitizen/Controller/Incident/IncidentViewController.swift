//
//  IncidentViewController.swift
//  FirstCitizen
//
//  Created by Fury on 10/09/2019.
//  Copyright © 2019 Kira. All rights reserved.
//

import UIKit

class IncidentViewController: UIViewController {
  var sampleIncidentData = DetailIncidentData(category: "Missing", id: 1, coordinate: [37.555429, 126.859272], mainAddress: "서울특별시 강서구 등촌동", detailAddress: "증미역 남자화장실 첫번째 칸", uploadTime: "2019-05-06 목요일", servicePoint: 100, userPoint: 50, title: "화장실 휴지좀..", contents: "어디 화장실인데 화장실 휴지가 너무 필요해요!! 빨리 부탁드려요!!", occurredTime: "", contentImage: "")
  
  var category: String = ""
  
  lazy var incidentView = IncidentView(frame: .zero, category: category)
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    
    attribute()
    layout()
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    
    testFunc()
  }
  
  private func testFunc() {
//    let decoder = JSONDecoder()
//    if let data = try? decoder.decode(DetailIncidentData.self, from: sampleJsonDetailData1) {
//      incidentView.changeAttribute(detailIncidentData: data)
//    } else {
//      print("[Log] : error")
//    }
    incidentView.changeAttribute(detailIncidentData: sampleIncidentData)
  }
  
  private func attribute() {
    incidentView.delegate = self
    incidentView.category = category
  }
  
  private func layout() {
    self.view.addSubview(incidentView)
    
    incidentView.snp.makeConstraints {
      $0.top.leading.trailing.equalToSuperview()
      $0.bottom.equalTo(self.view.safeAreaLayoutGuide)
    }
  }
}

extension IncidentViewController: IncidentViewDelegate {
  func touchUpHelpButton(category: String) {
    if category == "Restroom" {
      let alertController = UIAlertController(title: "도움주기", message: "당신의 빠른 도움이 한 사람의 항문을 지켜줄 수 있습니다.", preferredStyle: .alert)
      let okButton = UIAlertAction(title: "완료", style: .default, handler: nil)
      let cancelButton = UIAlertAction(title: "취소", style: .cancel) { [weak self] _ in
        self?.dismiss(animated: true, completion: nil)
      }
      
      alertController.addAction(okButton)
      alertController.addAction(cancelButton)
      self.present(alertController, animated: true, completion: nil)
    } else {
      let reportVC = ReportViewController()
      self.present(reportVC, animated: true, completion: nil)
    }
  }

  func touchUpBackButton() {
    self.dismiss(animated: true, completion: nil)
  }
}
