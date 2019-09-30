//
//  SettingRequestViewController.swift
//  FirstCitizen
//
//  Created by Lee on 23/09/2019.
//  Copyright © 2019 Kira. All rights reserved.
//

import UIKit

class SettingRequestViewController: UIViewController {
  
  private let categoryShared = CategoryDataManager.shared
  var requestIncidentDatas: [IncidentData] = []
  private let tableView = UITableView()
  
  private var categoryList: [String] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    extractCategory()
    navigationSet()
    configure()
    autoLayout()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(true)
    
    navigationController?.navigationBar.isHidden = false
    MainTabBarController.vTabBarButton.isHidden = true
  }
  
  private func navigationSet() {
    navigationItem.title = "의 뢰"
    navigationController?.navigationBar.shadowImage = UIImage()
    navigationController?.navigationBar.barTintColor = .white
    
    let backButton = UIBarButtonItem(image: UIImage(named: "navi-arrow-24x24"), style: .done, target: self, action: #selector(touchUpBackButton))
    navigationItem.leftBarButtonItem = backButton
  }
  
  @objc func touchUpBackButton() {
    MainTabBarController.vTabBarButton.isHidden = false
    navigationController?.popViewController(animated: true)
  }
  
  // 카테고리 이름만 추출하여 categoryList 배열에 저장
  private func extractCategory() {
    let categoryData = categoryShared.categoryData
    
    categoryList = categoryData.map { $0.name }
  }
  
  private func configure() {
    view.backgroundColor = .white
    
    tableView.delegate = self
    tableView.dataSource = self
    tableView.separatorStyle = .none
    view.addSubview(tableView)
  }
  
  private struct Standard {
    static let space: CGFloat = 8
    
  }
  
  private func autoLayout() {
    let guide = view.safeAreaLayoutGuide
    let margin: CGFloat = 10
    
    tableView.snp.makeConstraints {
      $0.top.equalTo(guide.snp.top)
      $0.leading.equalTo(guide.snp.leading).offset(margin.dynamic(1))
      $0.trailing.equalTo(guide.snp.trailing).offset(-margin.dynamic(1))
      $0.bottom.equalTo(guide.snp.bottom)
    }
  }
}

extension SettingRequestViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return requestIncidentDatas.count + 1
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    switch indexPath.row {
    case 0:
      let cell = UITableViewCell()
      cell.selectionStyle = .none
      
      let label = UILabel()
      label.text = "의뢰하기"
      label.upsFontBold(ofSize: 25)
      label.textColor = .white
      label.textAlignment = .center
      label.backgroundColor = UIColor.appColor(.appColor)
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
      let cell = ListViewCell()
      cell.selectionStyle = .none
      cell.changePreviewContainer(requestIncidentDatas[indexPath.row - 1])
      return cell
    }
  }
}

extension SettingRequestViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    switch indexPath.row {
      // 의뢰하기
    case 0:
      UIAlertController.registerShowSetting(categoryList: categoryList, title: "의뢰하기", message: "아래 목록중 하나를 선택하세요", from: self)
      
      // 기록
    default:
      let requestDetailVC = RequestDetailViewController()
      let reportShared = ReportDataManager.shared
      reportShared.relatedRequestData = requestIncidentDatas[indexPath.row - 1]
      reportShared.relatedRequestIdx = requestIncidentDatas[indexPath.row - 1].id
      NetworkService.getRequestHelpData(requestID: requestIncidentDatas[indexPath.row - 1].id) { [weak self] result in
        switch result {
        case .success(let data):
          requestDetailVC.category = (self?.categoryList[((self?.requestIncidentDatas[indexPath.row - 1])?.category)! - 1])!
          requestDetailVC.requestDetailData = self?.requestIncidentDatas[indexPath.row - 1]
          let reportShared = ReportDataManager.shared
          reportShared.reportDatas = data
          reportShared.reportCategory = (self?.categoryList[((self?.requestIncidentDatas[indexPath.row - 1])?.category)! - 1])!
          self?.present(requestDetailVC, animated: true, completion: nil)
        case .failure(let err):
          print(err.localizedDescription)
        }
      }
      break
    }
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    let normalHeight: CGFloat = 80
    let rowHeight: CGFloat = 180
    
    if indexPath.row == 0 {
      return normalHeight.dynamic(1)
    } else {
      return rowHeight.dynamic(1)
    }
  }
}
