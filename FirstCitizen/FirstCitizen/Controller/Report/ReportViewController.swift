//
//  ReportViewController.swift
//  FirstCitizen
//
//  Created by Fury on 19/09/2019.
//  Copyright © 2019 Kira. All rights reserved.
//

import UIKit
import TLPhotoPicker

class ReportViewController: UIViewController {
  
  private let reportView = ReportView()
  
  var detailIncidentData: IncidentData?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    reportView.attachFileButton.addTarget(self, action: #selector(didTapAttachFileButton(_:)), for: .touchUpInside)
    attribute()
    layout()
  }
  
  private func attribute() {
    self.view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    reportView.delegate = self
    reportView.titleTextField.delegate = self
    reportView.contentsTextField.delegate = self
  }
  
  private func layout() {
    self.view.addSubview(reportView)
    
    reportView.snp.makeConstraints {
      $0.top.leading.trailing.bottom.equalToSuperview()
    }
  }
  
  @objc private func didTapAttachFileButton(_ sender: UIButton) {
    print("didTapAttachFileButton")
    reportView.imageArr = []
    let pickerVC = TLPhotosPickerViewController()
    pickerVC.delegate = self
//    var configure = TLPhotosPickerConfigure()
    self.present(pickerVC, animated: true)
  }
}

extension ReportViewController: ReportViewDelegate {
  func touchUpReportButton(title: String, content: String, isAgree: Bool, images: [UIImage]) {
    let origin = detailIncidentData!
    let data = ReportData(request: origin.id, author: origin.author, title: title, content: content, isAgreedInform: isAgree, helpedAt: "", createdAt: "", updatedAt: "", images: [])
    
    NetworkService.report(data: data, images: images) {
      if $0 {
        DispatchQueue.main.async {
          if let navi = self.navigationController {
            navi.popViewController(animated: true)
          } else {
            self.dismiss(animated: true)
          }
        }
      }
      print($0)
    }
  }
  
  func touchUpBackButton() {
    self.dismiss(animated: true, completion: nil)
  }
}

extension ReportViewController: UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    if textField.returnKeyType == .continue {
      reportView.contentsTextField.becomeFirstResponder()
    } else {
      textField.resignFirstResponder()
    }
    return true
  }
}

extension ReportViewController: TLPhotosPickerViewControllerDelegate {
  func dismissPhotoPicker(withTLPHAssets: [TLPHAsset]) {
    self.reportView.selectedAssets = withTLPHAssets
  }
}
