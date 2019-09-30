//
//  ReportHelpDetailViewController.swift
//  FirstCitizen
//
//  Created by Fury on 30/09/2019.
//  Copyright © 2019 Kira. All rights reserved.
//

import UIKit

class ReportHelpDetailViewController: UIViewController {
  
  var reportHelpDetailData: ReportData?
  
  private let backButton = UIButton()
  var reportHelpDetailTableView = UITableView()
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    attribute()
    layout()
  }
  
  @objc private func touchUpBackButton() {
    self.dismiss(animated: true, completion: nil)
  }
  
  private func attribute() {
    self.view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    backButton.setImage(#imageLiteral(resourceName: "Back_Button"), for: .normal)
    backButton.addTarget(self, action: #selector(touchUpBackButton), for: .touchUpInside)
    
    reportHelpDetailTableView.separatorStyle = .none
    reportHelpDetailTableView.dataSource = self
    reportHelpDetailTableView.register(TitleCell.self, forCellReuseIdentifier: TitleCell.identifier)
    reportHelpDetailTableView.register(AttatchedFileCell.self, forCellReuseIdentifier: AttatchedFileCell.identifier)
    reportHelpDetailTableView.register(ContentsCell.self, forCellReuseIdentifier: ContentsCell.identifier)
  }
  
  private func layout() {
    let margin: CGFloat = 10
    view.addSubview(backButton)
    view.addSubview(reportHelpDetailTableView)
    
    backButton.snp.makeConstraints {
      $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
      $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(margin.dynamic(1))
      $0.width.height.equalTo(margin.dynamic(3) + 5)
    }
    
    reportHelpDetailTableView.snp.makeConstraints {
      $0.top.equalTo(backButton.snp.bottom).offset(margin.dynamic(2))
      $0.leading.equalTo(view).offset(margin.dynamic(1))
      $0.trailing.equalTo(view).offset(-margin.dynamic(1))
      $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
    }
  }
}

extension ReportHelpDetailViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 3
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if indexPath.row == 0 {
      let cell = tableView.dequeueReusableCell(withIdentifier: TitleCell.identifier, for: indexPath) as! TitleCell
      let title = reportHelpDetailData?.title ?? ""
      let iconImageStr = ""
      cell.titleUnderLineLabel.isHidden = true
      cell.modifyProperties(title, iconImageStr)
      cell.selectionStyle = .none
      return cell
    } else if indexPath.row == 1 {
      let cell = tableView.dequeueReusableCell(withIdentifier: AttatchedFileCell.identifier, for: indexPath) as! AttatchedFileCell
      let imgStr = reportHelpDetailData?.images ?? []
      cell.modifyProperties(imagesStr: imgStr)
      cell.selectionStyle = .none
      return cell
    } else {
      let cell = tableView.dequeueReusableCell(withIdentifier: ContentsCell.identifier, for: indexPath) as! ContentsCell
      let contents = reportHelpDetailData?.content ?? ""
      cell.modifyProperties(contents)
      cell.selectionStyle = .none
      return cell
    }
  }
}
