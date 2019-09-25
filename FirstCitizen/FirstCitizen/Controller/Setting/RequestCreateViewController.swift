//
//  RequestCreateViewController.swift
//  FirstCitizen
//
//  Created by Lee on 25/09/2019.
//  Copyright © 2019 Kira. All rights reserved.
//

import UIKit

class RequestCreateViewController: UIViewController {
  
  private let tableView = UITableView()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    navigationSet()
    configure()
    autoLayout()
  }
  
  private func navigationSet() {
    navigationItem.title = ""
    navigationController?.navigationBar.prefersLargeTitles = true
    navigationController?.navigationBar.shadowImage = UIImage()
    navigationController?.navigationBar.barTintColor = .white
  }
  
  private func configure() {
    view.backgroundColor = .white
    
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
