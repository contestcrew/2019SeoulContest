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
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    configure()
    autoLayout()
  }
  
  private func configure() {
    view.backgroundColor = .white
    
    tableView.contentInsetAdjustmentBehavior = .never
    tableView.separatorStyle = .none
    tableView.dataSource = self
    view.addSubview(tableView)
  }
  
  private struct Standard {
    static let space: CGFloat = 8
    
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
    return 1
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    switch indexPath.row {
    case 0:
      let cell = SettingProfileCell()
      
      return cell
      
    default:
      let cell = UITableViewCell()
      
      
      return cell
    }
  }
}
