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
  
  private let policeStation = [
    "없음",
    "서울 강남 경찰서",
    "서울 강동 경찰서",
    "서울 강북 경찰서",
    "서울 강서 경찰서",
    "서울 관악 경찰서",
    "서울 광진 경찰서",
    "서울 구로 경찰서",
    "서울 금천 경찰서",
    "서울 남대문 경찰서",
    "서울 노원 경찰서",
    "서울 도봉 경찰서",
    "서울 동대문 경찰서",
    "서울 동작 경찰서",
    "서울 마포 경찰서",
    "서울 방배 경찰서",
    "서울 서대문 경찰서",
    "서울 서부 경찰서",
    "서울 서초 경찰서",
    "서울 성동 경찰서",
    "서울 성북 경찰서",
    "서울 송파 경찰서",
    "서울 수서 경찰서",
    "서울 양천 경찰서",
    "서울 영등포 경찰서",
    "서울 용산 경찰서",
    "서울 은평 경찰서",
    "서울 종로 경찰서",
    "서울 종암 경찰서",
    "서울 중량 경찰서",
    "서울 중부 경찰서",
    "서울 혜화 경찰서"
  ]
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    navigationSet()
    configure()
    autoLayout()
  }
  
  private func navigationSet() {
    navigationItem.title = "의뢰하기"
    
    let barButton = UIBarButtonItem(title: "의 뢰", style: .done, target: self, action: #selector(barButtonAction))
    navigationItem.rightBarButtonItem = barButton
  }
  
  @objc private func barButtonAction() {
    
  }
  
  private func configure() {
    view.backgroundColor = .white
    
    tableView.dataSource = self
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

extension RequestCreateViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 10
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    switch indexPath.row {
    case 0:
      let cell = UITableViewCell()
      
      cell.selectionStyle = .none
      cell.textLabel?.text = " 관할 경찰서"
      cell.textLabel?.upsFontHeavy(ofSize: 24)
      
      return cell
      
    case 1:
      let cell = RequestCreatePoliceStationCell()
      
      cell.picker.dataSource = self
      cell.picker.delegate = self
      
      return cell
      
    case 2:
      let cell = UITableViewCell()
      
      cell.selectionStyle = .none
      cell.textLabel?.text = " 위치 입력"
      cell.textLabel?.upsFontHeavy(ofSize: 24)
      
      return cell
      
    case 3:
      let cell = UITableViewCell()
      
      cell.selectionStyle = .none
      cell.textLabel?.text = "현재위치"
      cell.textLabel?.textAlignment = .center
      cell.textLabel?.upsFontHeavy(ofSize: 15)
      
      return cell
      
    case 4:
      let cell = RequestCreateAddressCell()
      
      cell.setting(type: .map)
      
      return cell
      
    case 5:
      let cell = RequestCreateAddressCell()
      
      cell.setting(type: .text)
      
      return cell
      
    case 6:
      let cell = UITableViewCell()
      
      cell.selectionStyle = .none
      cell.textLabel?.text = " 제목"
      cell.textLabel?.upsFontHeavy(ofSize: 24)
      
      return cell
      
    case 7:
      let cell = RequestCreateTextAddCell()
      
      cell.setting(type: .field)
      cell.textField.delegate = self
      
      return cell
      
    case 8:
      let cell = UITableViewCell()
      
      cell.selectionStyle = .none
      cell.textLabel?.text = " 내용"
      cell.textLabel?.upsFontHeavy(ofSize: 24)
      
      return cell
      
    case 9:
      let cell = RequestCreateTextAddCell()
      
      cell.setting(type: .view)
      
      return cell
      
    default:
      return UITableViewCell()
    }
  }
}

extension RequestCreateViewController: UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    return true
  }
}

extension RequestCreateViewController: UIPickerViewDataSource {
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
  }
  
  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return policeStation.count
  }
}

extension RequestCreateViewController: UIPickerViewDelegate {
  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    return policeStation[row]
  }
}
