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
  
  private func navigationSet() {
    navigationItem.title = "의 뢰"
    navigationController?.navigationBar.prefersLargeTitles = true
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
    
    return UITableViewCell()
  }
}
