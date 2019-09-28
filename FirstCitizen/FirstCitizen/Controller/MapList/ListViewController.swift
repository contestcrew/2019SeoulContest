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
  
  // MARK:- Properties
  let homeIncidentShared = IncidentDataManager.shared
  let categoryShared = CategoryDataManager.shared
  
  private var categoryList = ["전체"]
  
  var incidentData: [IncidentData] = []
  var indexedIncidentData: [IncidentData] = []
  var backUpIndexedIncidentData: [IncidentData] = []
  var searchedIncidentData: [IncidentData] = []
  
  private let listView = ListView()
  private let listViewTableView = UITableView()
  
  // MARK:- LifeCycles
  override func viewDidLoad() {
    super.viewDidLoad()
    
    displayDatasInMap()
    configure()
    autoLayout()
  }
  
  override func viewWillLayoutSubviews() {
    super.viewWillLayoutSubviews()
    
    extractCategory()
  }
  
  // MARK:- Methods
  // 한글이 정확한 조합이 안되어서 나옴
  private func searchingIncidentData(searchedText: String) {
    backUpIndexedIncidentData = indexedIncidentData
    
    searchedIncidentData = []
    
    indexedIncidentData.forEach {
      if $0.title.contains(searchedText) || $0.content.contains(searchedText) {
        searchedIncidentData.append($0)
      }
    }
    
    indexedIncidentData = searchedIncidentData
    self.listViewTableView.reloadData()
  }
  
  private func indexingIncidentData(category: Int, incidentDatas: [IncidentData]) {
    indexedIncidentData = []
    
    incidentDatas.forEach {
      if category == 0 {
        indexedIncidentData = incidentDatas
        return
      } else {
        if $0.category == category {
          indexedIncidentData.append($0)
        }
      }
    }
    
    backUpIndexedIncidentData = indexedIncidentData
  }
  
  private func extractCategory() {
    categoryList = ["전체"]
    let categoryData = categoryShared.categoryData
    categoryData.forEach {
      categoryList.append($0.name)
    }
    listView.categoryList = categoryList
  }
  
  private func displayDatasInMap() {
    guard let homeIncidentDatas = homeIncidentShared.incidentDatas else { return }
    
    indexedIncidentData = homeIncidentDatas
    backUpIndexedIncidentData = indexedIncidentData
    listViewTableView.reloadData()
  }
  
  private func configure() {
    view.backgroundColor = .white
    listView.delegate = self
    
    let rowHeight: CGFloat = 180
    listViewTableView.showsVerticalScrollIndicator = false
    listViewTableView.separatorStyle = .none
    listViewTableView.dataSource = self
    listViewTableView.delegate = self
    listViewTableView.rowHeight = rowHeight.dynamic(1)
    listViewTableView.register(ListViewCell.self, forCellReuseIdentifier: ListViewCell.identifier)
  }
  
  private struct Standard {
    static let space: CGFloat = 8
    
  }
  
  private func autoLayout() {
    let guide = view.safeAreaLayoutGuide
    let safeBottmHeight = view.safeAreaInsets.bottom
    let margin: CGFloat = 10
    
    [listView, listViewTableView].forEach { self.view.addSubview($0) }
    
    listView.snp.makeConstraints {
      $0.top.equalTo(guide.snp.top).offset(margin.dynamic(1))
      $0.leading.trailing.equalToSuperview()
      $0.height.equalTo(margin.dynamic(10))
    }
    
    listViewTableView.snp.makeConstraints {
      $0.top.equalTo(listView.snp.bottom).offset(margin.dynamic(3))
      $0.leading.equalToSuperview().offset(margin.dynamic(1))
      $0.trailing.equalToSuperview().offset(-margin.dynamic(1))
      $0.bottom.equalTo(guide.snp.bottom).offset(-TabBarButtonView.height - safeBottmHeight - margin.dynamic(2))
    }
  }
}

// MARK:- UITableViewDataSource Extension
extension ListViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
    return indexedIncidentData.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: ListViewCell.identifier, for: indexPath) as! ListViewCell
    
    cell.changePreviewContainer(indexedIncidentData[indexPath.row])
    return cell
  }
}

// MARK:- UITableViewDelegate Extension
extension ListViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let incidentVC = IncidentViewController()
    
    let categoryNum = indexedIncidentData[indexPath.row].category
    incidentVC.category = categoryList[categoryNum]
    incidentVC.detailIncidentData = indexedIncidentData[indexPath.row]
    self.present(incidentVC, animated: true, completion: nil)
  }
}

// MARK:- ListViewDelegate Extension
extension ListViewController: ListViewDelegate {
  func searchIncidents(searchingText: String) {
    indexedIncidentData = backUpIndexedIncidentData
    searchingIncidentData(searchedText: searchingText)
  }
  
  func touchUpCategory(categoryIndex: Int) {
    indexingIncidentData(category: categoryIndex, incidentDatas: homeIncidentShared.incidentDatas!)
    listViewTableView.reloadData()
  }
}
