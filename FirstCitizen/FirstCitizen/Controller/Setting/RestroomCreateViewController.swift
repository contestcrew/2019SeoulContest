//
//  RestroomCreateViewController.swift
//  FirstCitizen
//
//  Created by Lee on 24/09/2019.
//  Copyright © 2019 Kira. All rights reserved.
//

import UIKit
import NMapsMap

enum CreateRoot {
  case map
  case setting
}

class RestroomCreateViewController: UIViewController {
  
  private let tableView = UITableView()
  
  var fromMap = true
  
  var cell0 = UITableViewCell()
  var cell1 = UITableViewCell()
  var cell2 = RequestCreateAddressCell()
  var cell3 = RequestCreateAddressCell()
  var cell4 = UITableViewCell()
  var cell5 = RequestCreateTextAddCell()
  var cell6 = UITableViewCell()
  var cell7 = RequestCreateTextAddCell()
  
  var mainAdd = ""
  var detailAdd = ""
  var shortAdd = "현재 위치"
  var location = NMGLatLng()
  
  var category = 1
  
  var root: CreateRoot?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    print("category in restroom", category)
    navigationSet()
    configure()
    autoLayout()
  }
  
  private func navigationSet() {
    navigationItem.title = "긴급 똥휴지"
    navigationController?.navigationBar.shadowImage = UIImage()
    navigationController?.navigationBar.barTintColor = .white
    
    let barButton = UIBarButtonItem(title: "의 뢰", style: .done, target: self, action: #selector(barButtonAction))
    barButton.tintColor = .blue
    navigationItem.rightBarButtonItem = barButton
    
    let backButton = UIBarButtonItem(image: UIImage(named: "navi-arrow-24x24"), style: .done, target: self, action: #selector(touchUpBackButton))
    backButton.tintColor = .blue
    navigationItem.leftBarButtonItem = backButton
  }
  
  @objc func touchUpBackButton() {
    guard let tempRoot = root else { return }
    
    switch tempRoot {
    case .map:
      presentingViewController?.dismiss(animated: true)
      
    case .setting:
      navigationController?.popViewController(animated: true)
    }
  }
  
  @objc private func barButtonAction() {
    // 의뢰 하는 버튼 카테고리 꼭 바꿔야함 동적으로
    let titleCell = cell5
    let title = titleCell.textField.text ?? "오류"
    
    let contentCell = cell7
    let content = contentCell.textView.text ?? "오류"
    
    let lat = location.lat
    let lng = location.lng
    
    let timeFormatter = DateFormatter()
    timeFormatter.locale = Locale(identifier: "ko")
    timeFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    let time = timeFormatter.string(from: Date())
    
    print("category: ", category)
    
    let requestData = RequestData(category: category,
                                  police: 0,
                                  title: title,
                                  content: content,
                                  score: 50,
                                  mainAdd: mainAdd,
                                  detailAdd: detailAdd,
                                  lat: lat,
                                  lng: lng,
                                  time: time)
    
    NetworkService.createRequest(data: requestData) {
      if $0 {
        DispatchQueue.main.async {
          if self.fromMap {
            self.dismiss(animated: true)
          } else {
            self.navigationController?.popViewController(animated: true)
          }
        }
      }
      print($0)
    }
  }
  
  private func configure() {
    view.backgroundColor = .white
    
    tableView.dataSource = self
    tableView.delegate = self
    tableView.separatorStyle = .none
    view.addSubview(tableView)
    
    view.bindToKeyboard()
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

extension RestroomCreateViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 8
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    switch indexPath.row {
    case 0:
      let cell = cell0
      
      cell.selectionStyle = .none
      cell.textLabel?.text = " 위치 입력"
      cell.textLabel?.upsFontHeavy(ofSize: 24)
      
      return cell
      
    case 1:
      let cell = cell1
      
      cell.selectionStyle = .none
      cell.textLabel?.text = "\(shortAdd) \(detailAdd)"
      cell.textLabel?.textAlignment = .center
      cell.textLabel?.upsFontHeavy(ofSize: 15)
      
      return cell
      
    case 2:
      let cell = cell2
      
      cell.setting(type: .map)
      
      return cell
      
    case 3:
      let cell = cell3
      
      cell.setting(type: .text)
      
      return cell
      
    case 4:
      let cell = cell4
      
      cell.selectionStyle = .none
      cell.textLabel?.text = " 제목"
      cell.textLabel?.upsFontHeavy(ofSize: 24)
      
      return cell
      
    case 5:
      let cell = cell5
      
      cell.setting(type: .field)
      cell.textField.delegate = self
      
      return cell
      
    case 6:
      let cell = cell6
      
      cell.selectionStyle = .none
      cell.textLabel?.text = " 내용"
      cell.textLabel?.upsFontHeavy(ofSize: 24)
      
      return cell
      
    case 7:
      let cell = cell7
      
      cell.setting(type: .view)
      
      return cell
      
    default:
      return UITableViewCell()
    }
  }
}

extension RestroomCreateViewController: UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    return true
  }
}

extension RestroomCreateViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    switch indexPath.row {
      // did tap map
    case 2:
      let vc = LocationWithMap()
      vc.delegate = self
      navigationController?.pushViewController(vc, animated: true)
      
      // did tap address
    case 3:
      let vc = LocationWithAddVC()
      navigationController?.pushViewController(vc, animated: true)

      
    default:
      break
    }
  }
}


extension RestroomCreateViewController: LocationWithMapDelegate {
  func sendAddress(main: String, detail: String, short: String, location: NMGLatLng) {
    self.mainAdd = main
    self.detailAdd = detail
    self.shortAdd = short
    self.location = location
    self.tableView.reloadData()
  }
  
  
}
