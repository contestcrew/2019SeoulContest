//
//  ListViewController.swift
//  FirstCitizen
//
//  Created by Lee on 20/08/2019.
//  Copyright © 2019 Kira. All rights reserved.
//

import UIKit
import SnapKit

class ListViewController: UIViewController {
  
  var incidentData: [HomeIncidentData]?
  
  private let listView = ListView()
  
  private let tableView = UITableView()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    dataParsing(datas: sampleDatas)
    configure()
    autoLayout()
  }
  
  
  
  private func dataParsing(datas: [Data]) {
    var tag = 0
    
    DispatchQueue.main.async {
      datas.forEach {
        if let incidentData = try? JSONDecoder().decode(HomeIncidentData.self, from: $0) {
          self.incidentData?.append(incidentData)
        }
        tag += 1
      }
      self.tableView.reloadData()
    }
    
  }
  
  private func configure() {
    view.backgroundColor = .white
    tableView.dataSource = self
  }
  
  private struct Standard {
    static let space: CGFloat = 8
    
  }
  
  private func autoLayout() {
    let guide = view.safeAreaLayoutGuide
    
    [listView, tableView].forEach { self.view.addSubview($0) }
    
    listView.snp.makeConstraints {
      $0.top.equalTo(guide.snp.top).offset(10)
      $0.leading.trailing.equalToSuperview()
      $0.height.equalTo(50)
    }
    
    tableView.snp.makeConstraints {
      $0.top.equalTo(listView.snp.bottom).offset(10)
      $0.leading.trailing.equalToSuperview()
      $0.bottom.equalTo(guide.snp.bottom).offset(-TabBarButtonView.height)
    }
  }
  
}

extension ListViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    guard let incidentDataCount = incidentData?.count else { return 0 }
    return incidentDataCount
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: ListViewCell.identifier, for: indexPath) as! ListViewCell
    print("[Log2] :", incidentData![indexPath.row])
    cell.changePreviewContainer(incidentData![indexPath.row])
    return cell
  }
}
