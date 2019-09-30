//
//  ViewController.swift
//  FirstCitizenLayout
//
//  Created by Jeon-heaji on 28/09/2019.
//  Copyright © 2019 Jeon-heaji. All rights reserved.
//

import UIKit
import SnapKit
import NMapsMap
import MapKit

// MARK: - LocationWithAddVC

class LocationWithAddVC: UIViewController {
  
  var location = NMGLatLng()
  
  let locationManager = CLLocationManager()
  
  var tableData: NaverAdd? {
    didSet {
      tableView.reloadData()
    }
  }

  lazy var tableView: UITableView = {
    let tb = UITableView()
    return tb
  }()
  
  
  let searchTF: UITextField = {
    let textfield = UITextField()
    textfield.addTarget(self, action: #selector(editingChanged(_:)), for: .editingChanged)
    textfield.addTarget(self, action: #selector(didTapTF(_:)), for: .touchDown)
    textfield.placeholder = "도로명, 건물명, 번지 검색"
    textfield.borderStyle = .bezel
    return textfield
  }()
  
  let searchBtn: UIButton = {
    let button = UIButton(type: .custom)
    button.setImage(UIImage(named: "search"), for: .normal)
    button.tintColor = .gray
    return button
  }()
  
  let tipLabel: UILabel = {
    let label = UILabel()
    label.text = "우편번호 통합검색 Tip"
    label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
    return label
  }()
  
  let streetLabel: UILabel = {
    let label = UILabel()
    let attributedString = NSMutableAttributedString()
      .normal("∙ 도로명 + ", fontSize: 17)
      .bold(" 건물번호", fontSize: 17)
      .normal(" (예: 송파대로 570)", fontSize: 17)
    label.attributedText = attributedString
    label.textColor = .darkGray
    attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.black, range: NSRange(location: 1, length: 4))
    return label
  }()
  
  let townLabel: UILabel = {
    let label = UILabel()
    let attributedString = NSMutableAttributedString()
      .normal("∙ 동/읍/면/리  + ", fontSize: 17)
      .bold(" 건물번호", fontSize: 17)
      .normal(" (예: 신천동 7-30)", fontSize: 17)
    label.attributedText = attributedString
    label.textColor = .darkGray
    return label
  }()
  
  let buildingLabel: UILabel = {
    let label = UILabel()
    let attributedString = NSMutableAttributedString()
      .normal("∙ 건물명, 아파트명 + ", fontSize: 17)
      .bold(" 건물번호", fontSize: 17)
      .normal(" (예: 아크밸리)", fontSize: 17)
    label.attributedText = attributedString
    label.textColor = .darkGray
    return label
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = .white
    self.tableView.backgroundColor = .white
    locationManager.delegate = self
    checkAuthorizationStatus()
    addSubViews()
    setupSNP()
    setupNavigation()
  }
  
  // MARK: -  textfield tap했을때 tableView 나옵니다
  @objc private func didTapTF(_ sender: UITextField) {
    
    [tableView].forEach { self.view.addSubview($0) }
    
    tableView.dataSource = self
    tableView.delegate = self
    
    tableView.snp.makeConstraints {
      $0.top.equalTo(searchTF.snp.bottom).offset(30)
      $0.leading.trailing.bottom.equalToSuperview()
    }
    tableView.separatorStyle = .none
    tableView.register(SearchTableCell.self, forCellReuseIdentifier: SearchTableCell.identifire)
  }
  
  
  @objc private func editingChanged(_ sender: UITextField) {
    NetworkService.searchAddress(query: sender.text ?? "", location: location) { (result) in
      switch result {
      case .success(let data):
        self.tableData = data
      case .failure(let err):
        dump(err)
      }
    }
  }
  
  // MARK: -  searchTablCell 의 Button 클릭했을때 alert 띄우기
  @objc func didTapButton(_ sender: UIButton) {
    let add = tableData?.places[sender.tag].roadAddress
    let alert = UIAlertController(title: "상세주소 입력", message: add, preferredStyle: .alert)
    let enter = UIAlertAction(title: "입력", style: .default)
    let cancel = UIAlertAction(title: "취소", style: .destructive)
    alert.view.tintColor = UIColor.darkGray
    alert.addAction(enter)
    alert.addAction(cancel)
    alert.addTextField()
    present(alert, animated: true)
    
  }
  // MARK: - addSubView
  private func addSubViews() {
    [searchTF, searchBtn, tipLabel, streetLabel, townLabel, buildingLabel].forEach
      { self.view.addSubview($0) }
  }
  // MARK: - snapkit
  private func setupSNP() {
    
    searchTF.snp.makeConstraints {
      $0.top.equalToSuperview().offset(100)
      $0.leading.equalToSuperview().inset(40)
      $0.height.equalTo(40)
      $0.width.equalToSuperview().inset(50)
    }
    
     searchBtn.snp.makeConstraints {
      $0.top.equalToSuperview().offset(105)
      $0.leading.equalTo(searchTF.snp.trailing).offset(7)
      $0.width.height.equalTo(30)
        }
    
    tipLabel.snp.makeConstraints {
      $0.top.equalTo(searchTF.snp.bottom).offset(30)
      $0.leading.equalToSuperview().offset(40)
      
    }
    
    streetLabel.snp.makeConstraints {
      $0.top.equalTo(tipLabel.snp.bottom).offset(15)
      $0.leading.equalToSuperview().offset(30)
    }
    townLabel.snp.makeConstraints {
      $0.top.equalTo(streetLabel.snp.bottom).offset(15)
      $0.leading.equalToSuperview().offset(30)
    }
    buildingLabel.snp.makeConstraints {
      $0.top.equalTo(townLabel.snp.bottom).offset(15)
      $0.leading.equalToSuperview().offset(30)
    }
    
  }
  
  func checkAuthorizationStatus() {
    switch CLLocationManager.authorizationStatus() {
    case .notDetermined:
      locationManager.requestWhenInUseAuthorization()
    case .restricted, .denied:
      // Disable location features
      break
    case .authorizedWhenInUse:
      fallthrough
    case .authorizedAlways:
      startUpdatingLocation()
    @unknown default:
      break
    }
  }
  
  func startUpdatingLocation() {
    let status = CLLocationManager.authorizationStatus()
    guard status == .authorizedAlways || status == .authorizedWhenInUse, CLLocationManager.locationServicesEnabled() else { return }
    locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation // 정확도
    locationManager.distanceFilter = 5.0 // x 미터마다 체크
    locationManager.startUpdatingLocation()
  }
  
  private func setupNavigation() {
    let barButton = UIBarButtonItem(image: nil, style: .done, target: nil, action: nil)
    navigationItem.backBarButtonItem = barButton
    
    self.navigationController?.navigationBar.tintColor = .darkGray
    navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
    navigationController?.navigationBar.shadowImage = UIImage()
    navigationController?.navigationBar.isTranslucent = true
  }

}


extension LocationWithAddVC: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    // MARK: - 검색할때 들어와야할 cell 의 갯수
    return tableData?.meta.count ?? 1
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableCell.identifire, for: indexPath) as! SearchTableCell
    cell.selectionStyle = .none
    if tableData == nil {
      cell.searchBtn.setTitle("검색어를 입력하세요.", for: .normal)
    } else {
      let main = tableData?.places[indexPath.row]
      let name = main?.name
      cell.searchBtn.tag = indexPath.row
      cell.searchBtn.setTitle("\(name ?? "애러")", for: .normal)
      cell.searchBtn.addTarget(self, action: #selector(didTapButton(_:)), for: .touchUpInside)
    }
    // MARK: -  searchTableCell의 button의 addTarget
    
    return cell
  }
  
  // MARK: - cell 높이
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 100
  }
  
}

extension LocationWithAddVC: UITableViewDelegate {
  
}

// MARK:- CLLocationManagerDelegate Extension
extension LocationWithAddVC: CLLocationManagerDelegate {
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    if let coor = manager.location?.coordinate {
      self.location = NMGLatLng(from: coor)
    }
  }
}



