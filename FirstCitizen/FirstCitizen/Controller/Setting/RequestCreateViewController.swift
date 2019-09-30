//
//  RequestCreateViewController.swift
//  FirstCitizen
//
//  Created by Lee on 25/09/2019.
//  Copyright © 2019 Kira. All rights reserved.
//

import UIKit
import NMapsMap
import TLPhotoPicker

class RequestCreateViewController: UIViewController {
  
  private let tableView = UITableView()
  
  var fromMap = true
  
  var cell1 = RequestCreatePoliceStationCell()
  var cell7 = RequestCreateTextAddCell()
  var cell9 = RequestCreateTextAddCell()
  var cell10 = ImagePickerCell()

  var mainAdd = ""
  var detailAdd = ""
  var shortAdd = "현재 위치"
  var location = NMGLatLng()
  
  var category = 1
  
  var police = 0
  
  var imageArr = [UIImage]()
  
  var selectedAssets = [TLPHAsset]() {
    willSet(new) {
      imageArr = []
      new.forEach {
        imageArr.append($0.fullResolutionImage ?? UIImage())
      }
      cell10.imageArr = imageArr
    }
  }
  
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
  
  
  var root: CreateRoot?
  
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    print("category in create", category)
    navigationSet()
    configure()
    autoLayout()
  }
  
  private func navigationSet() {
    navigationItem.title = "의뢰하기"
    navigationController?.navigationBar.shadowImage = UIImage()
    navigationController?.navigationBar.barTintColor = .white
    
    let barButton = UIBarButtonItem(title: "의 뢰", style: .done, target: self, action: #selector(barButtonAction))
    navigationItem.rightBarButtonItem = barButton
    
    let backButton = UIBarButtonItem(image: UIImage(named: "navi-arrow-24x24"), style: .done, target: self, action: #selector(touchUpBackButton))
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
    print("didTapbarbtn")
    
    let titleCell = cell7
    let title = titleCell.textField.text ?? "오류"
    
    let contentCell = cell9
    let content = contentCell.textView.text ?? "오류"
    
    let lat = location.lat
    let lng = location.lng
    
    let timeFormatter = DateFormatter()
    timeFormatter.locale = Locale(identifier: "ko")
    timeFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    let time = timeFormatter.string(from: Date())
    
    print("category: ", category)
    
    let requestData = RequestData(category: category,
                                  police: police,
                                  title: title,
                                  content: content,
                                  score: 50,
                                  mainAdd: mainAdd,
                                  detailAdd: detailAdd,
                                  lat: lat,
                                  lng: lng,
                                  time: time)
    
    print(requestData)
    
    NetworkService.createRequestWithImage(data: requestData, images: imageArr) {
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
    
//    NetworkService.createRequest(data: requestData) {
//      if $0 {
//        self.dismiss(animated: true)
//      }
//      print($0)
//    }
    
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

extension RequestCreateViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 11
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
      let cell = cell1
      
//      cell.picker.selectRow(police, inComponent: police, animated: true)
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
      cell.textLabel?.text = "\(shortAdd) \(detailAdd)"
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
      let cell = cell7
      
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
      let cell = cell9
      
      cell.setting(type: .view)
      
      return cell
      
    case 10:
      let cell = cell10
      cell.delegate = self
//      cell.imageArr = self.imageArr
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
  
  func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    print("police: ", row)
    police = row
  }
}

extension RequestCreateViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    switch indexPath.row {
      // did tap map
    case 4:
      let vc = LocationWithMap()
      vc.delegate = self
      navigationController?.pushViewController(vc, animated: true)
      
      // did tap address
    case 5:
      let vc = LocationWithAddVC()
      navigationController?.pushViewController(vc, animated: true)
      
      
    default:
      break
    }
  }
  
}

extension RequestCreateViewController: LocationWithMapDelegate {
  func sendAddress(main: String, detail: String, short: String, location: NMGLatLng) {
    self.mainAdd = main
    self.detailAdd = detail
    self.shortAdd = short
    self.location = location
    self.tableView.reloadData()
  }
  
  
}

extension RequestCreateViewController: ImagePickerCellDelegate {
  func didTapImageAddBtn() {
    print("didTapImageAddBtn")
    let picker = TLPhotosPickerViewController()
    picker.delegate = self
    self.present(picker, animated: true)
  }
  
  func tableviewReload() {
    self.tableView.reloadData()
  }
  
   
}

extension RequestCreateViewController: TLPhotosPickerViewControllerDelegate {
  func dismissPhotoPicker(withTLPHAssets: [TLPHAsset]) {
    self.selectedAssets = withTLPHAssets
  }
}
