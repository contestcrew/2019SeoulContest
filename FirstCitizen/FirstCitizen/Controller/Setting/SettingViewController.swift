//
//  SettingViewController.swift
//  FirstCitizen
//
//  Created by Lee on 20/08/2019.
//  Copyright © 2019 Kira. All rights reserved.
//

import UIKit

enum ListType {
  case request
  case report
}

enum CategoryType: String {
  case type1 = "긴급 똥휴지"
  case type2 = "분실"
  case type3 = "접촉사고"
  case type4 = "뺑소니"
}

class SettingViewController: UIViewController {
  
  private let tableView = UITableView()
  
  private var requestList = [String]()  // 의뢰 목록
  private var reportList = [String]()   // 제보 목록
  
  private let categoryList = ["긴급 똥휴지", "분실", "접촉사고", "뺑소니"]
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    configure()
    autoLayout()
  }
  
  private func configure() {
    view.backgroundColor = .white
    
//    tableView.contentInsetAdjustmentBehavior = .never
    tableView.separatorStyle = .none
    tableView.dataSource = self
    tableView.delegate = self
    view.addSubview(tableView)
  }
  
  private func alertAction() {
    let alert = UIAlertController(title: "의뢰하기", message: "아래 목록 중 하나를 선택하세요", preferredStyle: .alert)
    
    categoryList.forEach { item in
      let action = UIAlertAction(title: item, style: .default, handler: { action in
//        guard let `self` = self, let type = CategoryType.init(rawValue: item) else { return }
        guard let type = CategoryType.init(rawValue: item) else { return }
        
        switch type {
        case .type1:
          print(type.rawValue)
          
        default:
          print(type.rawValue)
        }
      })
      
      alert.addAction(action)
    }
    
    
    let cancel = UIAlertAction(title: "취소", style: .cancel)
    alert.addAction(cancel)
    present(alert, animated: true)
  }
  
  private func autoLayout() {
    let guide = view.safeAreaLayoutGuide
    
    tableView.translatesAutoresizingMaskIntoConstraints = false
    tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
    tableView.leadingAnchor.constraint(equalTo: guide.leadingAnchor).isActive = true
    tableView.trailingAnchor.constraint(equalTo: guide.trailingAnchor).isActive = true
    tableView.bottomAnchor.constraint(equalTo: guide.bottomAnchor, constant: -TabBarButtonView.height).isActive = true
  }
  
}

extension SettingViewController: UITableViewDataSource {
  func numberOfSections(in tableView: UITableView) -> Int {
    return 3
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    switch indexPath.section {
    case 0:
      let cell = SettingProfileCell()
      
      return cell
      
    case 1:
      let cell = SettingListCell()
      
      cell.delegate = self
      cell.setting(type: .request, list: [String]())
      
      return cell
      
      
    case 2:
      let cell = SettingListCell()
      
      cell.delegate = self
      cell.setting(type: .report, list: [String]())
      
      return cell
      
    default:
      let cell = UITableViewCell()
      
      return cell
    }
  }
}


extension SettingViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    switch section {
    case 1:
      let vGuide = SettingGuideLineView()
      
      vGuide.title.text = "  의 뢰  "
      
      return vGuide
      
    case 2:
      let vGuide = SettingGuideLineView()
      
      vGuide.title.text = "  제 보  "
      
      return vGuide
      
    default:
      return UIView()
    }
  }
}

extension SettingViewController: SettingListCellDelegate {
  func addDidTap(type: ListType) {
    switch type {
    case .request:
      alertAction()
      
    case .report:
      print("report add")
    }
  }
  
  func noneDidTap(type: ListType) {
    switch type {
    case .request:
      print("request none")
      
    case .report:
      print("report none")
    }
  }
}
