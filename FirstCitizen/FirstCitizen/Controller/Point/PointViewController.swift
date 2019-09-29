//
//  PointViewController.swift
//  FirstCitizen
//
//  Created by Lee on 20/08/2019.
//  Copyright © 2019 Kira. All rights reserved.
//

import UIKit

class PointViewController: UIViewController {
  
  private let tableView = UITableView()
  private let couponList = ["botanicpark", "publicparking", "royalpalace", "sisul", "visitseoul"]
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    configure()
    autoLayout()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    tableView.reloadData()
  }
  
  private func configure() {
    view.backgroundColor = .white
    
    tableView.dataSource = self
    tableView.delegate = self
    tableView.separatorStyle = .none
    view.addSubview(tableView)
  }
  
  private func alertAction(tilte: String?, message: String?) {
    let alert = UIAlertController(title: tilte, message: message, preferredStyle: .alert)
    let cancel = UIAlertAction(title: "cancel", style: .cancel) { (action) in
      
    }
    alert.addAction(cancel)
    present(alert, animated: true)
  }
  
  @objc private func couponAction() {
    alertAction(tilte: "서비스 예정", message: nil)
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
    tableView.bottomAnchor.constraint(equalTo: guide.bottomAnchor, constant: -TabBarButtonView.height - 20).isActive = true
  }
}

extension PointViewController: UITableViewDataSource {
  func numberOfSections(in tableView: UITableView) -> Int {
    return 3
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    switch section {
    case 2:
      return couponList.count
      
    default:
      return 1
    }
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    switch indexPath.section {
    case 0:
      let cell = PointCardCell()
      let userShared = UserInfoManager.shared
      cell.cellModify(point: userShared.userInfo!.citizenScore ,nickname: userShared.userInfo!.username)
      return cell
      
    case 1:
      let cell = PointStampCell()
      
      return cell
      
      
    default:
      let cell = PointCouponCell()
      
      cell.setting(imageName: couponList[indexPath.row])
      cell.button.addTarget(self, action: #selector(couponAction), for: .touchUpInside)
      
      return cell
    }
  }
}

extension PointViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    switch indexPath.section {
    case 1:
      return alertAction(tilte: "서비스 예정", message: nil)
      
    default:
      break
    }
  }
}
