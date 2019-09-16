//
//  IncidentViewController.swift
//  FirstCitizen
//
//  Created by Fury on 10/09/2019.
//  Copyright © 2019 Kira. All rights reserved.
//

import UIKit

class IncidentViewController: UIViewController {
  var category: String = ""
  
  lazy var incidentView = IncidentView(frame: .zero, category: category)
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    
    attribute()
    layout()
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
  func touchUpHelpButton() {
    let alertController = UIAlertController(title: "도움주기", message: "당신의 빠른 도움이 한 사람의 항문을 지켜줄 수 있습니다.", preferredStyle: .alert)
    let okButton = UIAlertAction(title: "완료", style: .default, handler: nil)
    let cancelButton = UIAlertAction(title: "취소", style: .cancel) { [weak self] _ in
      self?.dismiss(animated: true, completion: nil)
    }
    
    alertController.addAction(okButton)
    alertController.addAction(cancelButton)
    self.present(alertController, animated: true, completion: nil)
  }
  
  func touchUpBackButton() {
    self.dismiss(animated: true, completion: nil)
  }
}
