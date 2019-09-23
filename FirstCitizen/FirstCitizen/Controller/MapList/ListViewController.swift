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
  //TODO: Api를 통해서 카테고리 리스트를 가저올 예정
  private let sampleCategoryList = ["전체", "똥휴지", "사고", "실종", "분실"]
  
  var incidentData: [HomeIncidentData] = []
  var indexedIncidentData: [HomeIncidentData] = []
  var backUpIndexedIncidentData: [HomeIncidentData] = []
  var searchedIncidentData: [HomeIncidentData] = []
  
  private let listView = ListView()
  
  private let listViewTableView = UITableView()
  
  // MARK:- LifeCycles
  override func viewDidLoad() {
    super.viewDidLoad()
    
    dataParsing(datas: sampleDatas)
    
    configure()
    autoLayout()
  }
  
  override func viewWillLayoutSubviews() {
    super.viewWillLayoutSubviews()
    
    listView.sampleCategoryList = sampleCategoryList
  }
  
  // MARK:- Methods
  // 한글이 정확한 조합이 안되어서 나옴
  private func searchingIncidentData(searchedText: String) {
    indexedIncidentData = backUpIndexedIncidentData
    searchedIncidentData = []
    
    indexedIncidentData.forEach {
      if $0.title.contains(searchedText) || $0.contents.contains(searchedText) {
        searchedIncidentData.append($0)
      }
    }
    
    indexedIncidentData = searchedIncidentData
    self.listViewTableView.reloadData()
  }
  
  private func indexingIncidentData(category: String, incidentDatas: [HomeIncidentData]) {
    indexedIncidentData = []
    
    incidentDatas.forEach {
      if category == "전체" {
        indexedIncidentData = incidentDatas
        return
      }
      
      //TODO: 카테고리가 영어로 되어있으나, 선택되는 카테고리 이름은 한국어임
      if $0.category == category {
        indexedIncidentData.append($0)
      }
    }
    
    backUpIndexedIncidentData = indexedIncidentData
  }
  
  
  private func dataParsing(datas: [Data]) {
    var tag = 0
    incidentData = []
    DispatchQueue.main.async {
      datas.forEach {
        if let incidentData = try? JSONDecoder().decode(HomeIncidentData.self, from: $0) {
          self.incidentData.append(incidentData)
        }
        tag += 1
      }
      self.indexedIncidentData = self.incidentData
      self.listViewTableView.reloadData()
    }
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
    
    //TODO: indexpath.row의 값으로 incidentData[]의 값을 찾고, id 값으로 API를 호출하여 detail Data 가져오고 카테고리 수정 및 넘김.
    incidentVC.category = "Missing"
    self.present(incidentVC, animated: true, completion: nil)
  }
}

// MARK:- ListViewDelegate Extension
extension ListViewController: ListViewDelegate {
  func searchIncidents(searchingText: String) {
    searchingIncidentData(searchedText: searchingText)
  }
  
  func touchUpCategory(categoryIndex: Int) {
    indexingIncidentData(category: sampleCategoryList[categoryIndex], incidentDatas: incidentData)
    listViewTableView.reloadData()
  }
}
