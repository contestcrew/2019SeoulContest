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
  
  var requestIncidentDatas: [IncidentData] = []
  
  private let inDocument = ["의뢰", "도움", "공지사항", "이용약관", "내 정보"]
  private let outDocument = ["공지사항", "이용약관"]
  
  private var isSign = true
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    configure()
    autoLayout()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(true)
    
    navigationController?.navigationBar.isHidden = true
    
    if let _ = UserDefaults.standard.object(forKey: "Token") as? String {
      isSign = true
      tableView.reloadData()
    } else {
      isSign = false
      tableView.reloadData()
    }
  }
  
  private func configure() {
    view.backgroundColor = .white
    
    tableView.separatorStyle = .none
    tableView.dataSource = self
    tableView.delegate = self
    view.addSubview(tableView)
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
    switch isSign {
    case true:
      return 2 + inDocument.count
      
    case false:
      return 2 + outDocument.count
    }
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    switch isSign {
    case true:
      switch indexPath.row {
      case 0:
        let cell = SettingProfileCell()
        
        cell.setting(imageName: "leaf", nickName: "dldbdjq@gmail.com", creditPoint: 1200, point: 200)
        
        return cell
        
      case 1...5:
        let cell = SettingDocumentCell()
        
        cell.titleLabel.text = inDocument[indexPath.row - 1]
        
        if indexPath.row == 1 {
          cell.countLabel.isHidden = false
          var requestCount = 0
          
          requestIncidentDatas.forEach {
            if $0.status == "도움요청중" {
              requestCount += 1
            }
          }
          
          cell.countLabel.text = "\(requestCount)"
        }
        
        return cell
        
        
      default:
        let cell = UITableViewCell()
        
        cell.textLabel?.text = "로그아웃"
        cell.textLabel?.upsFontBold(ofSize: 20)
        cell.textLabel?.textColor = .red
        cell.textLabel?.textAlignment = .center
        cell.selectionStyle = .none
        
        return cell
      }
      
    case false:
      switch indexPath.row {
      case 0:
        let cell = SettingProfileCell()
        
        cell.setting(imageName: "leaf", nickName: "-", creditPoint: 0, point: 0)
        
        return cell
        
      case 1...2:
        let cell = SettingDocumentCell()
        
        cell.titleLabel.text = outDocument[indexPath.row - 1]
        
        return cell
        
        
      default:
        let cell = UITableViewCell()
        
        cell.textLabel?.text = "로그인"
        cell.textLabel?.upsFontBold(ofSize: 20)
        cell.textLabel?.textColor = .red
        cell.textLabel?.textAlignment = .center
        cell.selectionStyle = .none
        
        return cell
      }
    }
  }
}


extension SettingViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    switch isSign {
    case true:
      switch indexPath.row {
      case 0:
        break
        
      case 1:
        let vcSettingRequest = SettingRequestViewController()
        vcSettingRequest.requestIncidentDatas = requestIncidentDatas
        navigationController?.pushViewController(vcSettingRequest, animated: true)
        
      case 2...inDocument.count:
        print(indexPath.row)
        
      default:
        UserDefaults.standard.removeObject(forKey: "Token")
        isSign = false
        tableView.reloadData()
      }
      
    case false:
      switch indexPath.row {
      case 0:
        break
        
      case 1...outDocument.count:
        print(indexPath.row)
        
      default:
        let loginVC = UINavigationController(rootViewController: LoginVC())
        
        self.present(loginVC, animated: true)
      }
    }
  }
}
