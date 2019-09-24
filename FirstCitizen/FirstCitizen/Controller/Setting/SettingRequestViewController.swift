//
//  SettingRequestViewController.swift
//  FirstCitizen
//
//  Created by Lee on 23/09/2019.
//  Copyright © 2019 Kira. All rights reserved.
//

import UIKit

class SettingRequestViewController: UIViewController {
  
  private let tableView = UITableView()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    
    navigationSet()
    configure()
    autoLayout()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(true)
    
    navigationController?.navigationBar.isHidden = false
    MainTabBarController.vTabBarButton.isHidden = true
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewDidDisappear(true)
    MainTabBarController.vTabBarButton.isHidden = false
  }
  
  private func navigationSet() {
    navigationItem.title = "의 뢰"
    navigationController?.navigationBar.shadowImage = UIImage()
    navigationController?.navigationBar.barTintColor = .white
  }
  
  private func configure() {
    view.backgroundColor = .white
    
    tableView.dataSource = self
    view.addSubview(tableView)
  }
  
  private struct Standard {
    static let space: CGFloat = 8
    
  }
  
  private func autoLayout() {
    let guide = view.safeAreaLayoutGuide
    
    tableView.translatesAutoresizingMaskIntoConstraints = false
    tableView.topAnchor.constraint(equalTo: guide.topAnchor).isActive = true
    tableView.leadingAnchor.constraint(equalTo: guide.leadingAnchor).isActive = true
    tableView.trailingAnchor.constraint(equalTo: guide.trailingAnchor).isActive = true
    tableView.bottomAnchor.constraint(equalTo: guide.bottomAnchor).isActive = true
  }
}

extension SettingRequestViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return sampleDatas.count + 1
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    switch indexPath.row {
    case 0:
      let cell = UITableViewCell()
      
      let label = UILabel()
      label.text = "의뢰하기"
      label.upsFontBold(ofSize: 25)
      label.textColor = .white
      label.textAlignment = .center
      label.backgroundColor = .blue
      label.layer.cornerRadius = 16
      label.layer.masksToBounds = true
      cell.contentView.addSubview(label)
      
      label.translatesAutoresizingMaskIntoConstraints = false
      label.topAnchor.constraint(equalTo: cell.contentView.topAnchor, constant: 16).isActive = true
      label.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor, constant: 16).isActive = true
      label.trailingAnchor.constraint(equalTo: cell.contentView.trailingAnchor, constant: -16).isActive = true
      label.bottomAnchor.constraint(equalTo: cell.contentView.bottomAnchor, constant: -16).isActive = true
      label.heightAnchor.constraint(equalToConstant: 64).isActive = true
      
      return cell
      
    default:
      return ListViewCell()
    }
    
    
  }
}
