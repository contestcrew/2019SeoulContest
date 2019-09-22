//
//  SettingViewController.swift
//  FirstCitizen
//
//  Created by Lee on 20/08/2019.
//  Copyright © 2019 Kira. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController {
  
  private let tableView = UITableView()
  
//  private var requestList = [String]()  // 의뢰 목록
//  private var helpList = [String]()   // 도움 목록
  
  private let document = ["의뢰", "도움", "공지사항", "이용약관", "내 정보"]
  
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
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 7
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    switch indexPath.row {
    case 0:
      let cell = SettingProfileCell()
      
      return cell
      
    case 1...5:
      let cell = SettingDocumentCell()
      
      cell.titleLabel.text = document[indexPath.row - 1]
      
      if indexPath.row == 1 {
        cell.countLabel.isHidden = false
        cell.countLabel.text = "0"
      }
      
      return cell
      
      
    default:
      let cell = UITableViewCell()
      
      cell.textLabel?.text = "로그아웃"
      cell.textLabel?.upsFontBold(ofSize: 20)
      cell.textLabel?.textColor = .red
      cell.textLabel?.textAlignment = .center
      cell.selectionStyle = .none
      
      return cell
    }
  }
}


extension SettingViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    switch indexPath.row {
    case 1...5:
      print(indexPath.row)
      
    default:
      break
    }
  }
}
