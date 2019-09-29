//
//  MapView.swift
//  FirstCitizen
//
//  Created by Lee on 20/08/2019.
//  Copyright © 2019 Kira. All rights reserved.
//

import UIKit
import NMapsMap
import MapKit
import SnapKit

// MARK:- MapViewDelegate Protocol 선언부
protocol MapViewDelegate: class {
  func touchUpLocationButton(coordinate: CLLocationCoordinate2D)
  func touchUpPreview()
  func touchUpRefreshButton(coordinate: CLLocationCoordinate2D)
  func touchUpRegisterButton()
}

class MapView: UIView {
  
  // MARK:- Properties
  weak var delegate: MapViewDelegate?
  var isFirst: Bool = true
  var currentCoordinateValue: CLLocationCoordinate2D?
  
  let nMapLocationManager = NMFLocationManager()
  let nMapView = NMFNaverMapView(frame: .zero)
  
  private let locationManager = CLLocationManager()
  
  let camera = MKMapCamera()
  
  private let gradientView = UIImageView()
  
  let previewContainer = UIView()
  
  var firstExplainLabel = UILabel()
  
  private let imageView = UIImageView()
  private let titleLabel = UILabel()
  private let guideLabel = UILabel()
  private let dateLabel = UILabel()
  private let pointLabel = UILabel()
  private let contentsLabel = UILabel()
  private let progressLabel = UILabel()
  
  private let locationButton = UIButton(type: .custom)
  private let refreshButton = UIButton(type: .custom)
  private let registerButton = UIButton(type: .custom)
  
  // MARK:- LifeCycles
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    getCurrentLocation()
    autoLayout()
    mapSetting()
    nMapConfigure()
    
    previewContainer.isHidden = true
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    
    firstAttribute()
    attribute()
    
  }
  
  // MARK:- Methods
  func changePreviewContainer(_ homeIncidentData: IncidentData, _ iconImg: UIImage) {
    titleLabel.text = homeIncidentData.title
    imageView.image = iconImg
    
    guard let createdTime = homeIncidentData.createdAt else { return }
    let date = Date()
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
    let time = date.convertDateFormatter(date: createdTime)
    let dateTime = dateFormatter.date(from: time)
    let daysBetweenDate = date.daysBetweenDate(toDate: dateTime!)
    dateLabel.text = daysBetweenDate
    
    contentsLabel.text = homeIncidentData.content
    pointLabel.text = "Point \(homeIncidentData.categoryScore) + Bonus \(homeIncidentData.score)"
    let attributedStr = NSMutableAttributedString(string: pointLabel.text!)
    attributedStr.addAttribute(.foregroundColor, value: UIColor.blue, range: (pointLabel.text! as NSString).range(of: "Bonus"))
    attributedStr.addAttribute(.foregroundColor, value: UIColor.orange, range: (pointLabel.text! as NSString).range(of: "Point"))
    pointLabel.attributedText = attributedStr
  }
  
  // 현재 위치로 지도 이동하는 메서드
  @objc private func touchUpLocationButton() {
    guard let currentCoordinateValue = currentCoordinateValue else { return }
    delegate?.touchUpLocationButton(coordinate: currentCoordinateValue)
  }
  
  // 새로고침 버튼 메서드
  @objc private func touchUpRefreshButton() {
    delegate?.touchUpRefreshButton(coordinate: currentCoordinateValue!)
  }
  
  // 등록 버튼 메서드
  @objc private func touchUpRegisterButton() {
    delegate?.touchUpRegisterButton()
  }
  
  @objc private func touchUpPreview() {
    delegate?.touchUpPreview()
  }
  
  private func getCurrentLocation() {
    locationManager.delegate = self
  }
  
  private func nMapConfigure() {
    nMapView.mapView.mapType = .basic
    nMapView.mapView.logoAlign = .leftTop
    nMapView.positionMode = .direction
    nMapView.showLocationButton = false
    nMapView.showZoomControls = false
    nMapView.showCompass = false
    nMapView.showScaleBar = false
    nMapView.mapView.minZoomLevel = 15
    
    locationButton.setImage(#imageLiteral(resourceName: "MapCurrent"), for: .normal)
    locationButton.addTarget(self, action: #selector(touchUpLocationButton), for: .touchUpInside)
    locationButton.shadow()
    
    refreshButton.setImage(#imageLiteral(resourceName: "MapReset"), for: .normal)
    refreshButton.addTarget(self, action: #selector(touchUpRefreshButton), for: .touchUpInside)
    refreshButton.shadow()
    
    registerButton.setImage(#imageLiteral(resourceName: "MapAdd"), for: .normal)
    registerButton.addTarget(self, action: #selector(touchUpRegisterButton), for: .touchUpInside)
    registerButton.shadow()
  }
  
  private func firstAttribute() {
    firstExplainLabel.text = "곤경에 빠진 시민을 도와주세요"
    firstExplainLabel.textAlignment = .center
    firstExplainLabel.dynamicFont(fontSize: 24, weight: .bold)
  }
  
  func attribute() {
    gradientView.image = UIImage(named: "Gradient")
    gradientView.contentMode = .scaleToFill
    
    previewContainer.layer.borderWidth = 2
    previewContainer.layer.borderColor = UIColor.appColor(.appLayerBorderColor).cgColor
    previewContainer.layer.cornerRadius = 10
    let tap = UITapGestureRecognizer(target: self, action: #selector(touchUpPreview))
    previewContainer.addGestureRecognizer(tap)
    previewContainer.shadow()
    
    imageView.contentMode = .scaleAspectFit
    imageView.layer.cornerRadius = Standard.imageSize / 2
    imageView.image = UIImage(named: "Restroom")
    
    titleLabel.text = "굳어가고 있어요 헬프미"
    titleLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    titleLabel.dynamicFont(fontSize: 26, weight: .bold)
    
    guideLabel.backgroundColor = .black
    
    dateLabel.text = "2019-08-14 목요일"
    dateLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    dateLabel.dynamicFont(fontSize: 14, weight: .semibold)
    
    pointLabel.text = "Point 100 + Bonus 350"
    pointLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    pointLabel.textAlignment = .right
    pointLabel.dynamicFont(fontSize: 14, weight: .semibold)
    let attributedStr = NSMutableAttributedString(string: pointLabel.text!)
    attributedStr.addAttribute(.foregroundColor, value: UIColor.blue, range: (pointLabel.text! as NSString).range(of: "Bonus"))
    attributedStr.addAttribute(.foregroundColor, value: UIColor.orange, range: (pointLabel.text! as NSString).range(of: "Point"))
    pointLabel.attributedText = attributedStr
    
    contentsLabel.textColor = .darkGray
    contentsLabel.text = "굳어가고 있어요.. 헬퓨ㅡ미.."
    contentsLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    contentsLabel.dynamicFont(fontSize: 18, weight: .bold)
    
    progressLabel.text = "도움요청중"
    progressLabel.textAlignment = .center
    progressLabel.dynamicFont(fontSize: 22, weight: .heavy)
    progressLabel.textColor = UIColor.appColor(.appGreenColor)
  }
  
  private func mapSetting() {
    checkAuthorizationStatus()
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
  
  private struct Standard {
    static let space: CGFloat = 8
    
    static let imageSize: CGFloat = 64
  }
  
  private func autoLayout() {
    let margin: CGFloat = 10
    
    [nMapView, gradientView, locationButton, refreshButton, registerButton, previewContainer]
      .forEach { self.addSubview($0) }
    
    [firstExplainLabel]
      .forEach { self.addSubview($0) }
    
    [titleLabel, imageView, guideLabel, dateLabel, pointLabel, contentsLabel, progressLabel]
      .forEach { previewContainer.addSubview($0) }
    
    
    
    nMapView.snp.makeConstraints {
      $0.top.leading.trailing.equalTo(self)
      $0.height.equalTo(self).multipliedBy(0.75)
    }
    
    gradientView.snp.makeConstraints {
      $0.leading.trailing.equalTo(self)
      $0.bottom.equalTo(nMapView)
      $0.height.equalTo(margin.dynamic(10))
    }
    
    locationButton.snp.makeConstraints {
      $0.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(margin.dynamic(1))
      $0.trailing.equalTo(self).offset(-margin.dynamic(1))
      $0.width.height.equalTo(margin.dynamic(4))
    }
    
    refreshButton.snp.makeConstraints {
      $0.top.equalTo(locationButton.snp.bottom).offset(margin.dynamic(2))
      $0.trailing.equalTo(self).offset(-margin.dynamic(1))
      $0.width.height.equalTo(margin.dynamic(4))
    }
    
    registerButton.snp.makeConstraints {
      $0.top.equalTo(gradientView.snp.top)
      $0.trailing.equalTo(self).offset(-margin.dynamic(1))
      $0.width.height.equalTo(margin.dynamic(4))
    }
    
    previewContainer.snp.makeConstraints {
      $0.top.equalTo(gradientView.snp.bottom).offset(-margin.dynamic(1))
      $0.leading.equalTo(self).offset(margin.dynamic(1))
      $0.trailing.bottom.equalTo(self).offset(-margin.dynamic(1))
    }
  
    firstExplainLabel.snp.makeConstraints {
      $0.top.leading.trailing.bottom.equalTo(previewContainer)
    }
    
    titleLabel.snp.makeConstraints {
      $0.top.equalToSuperview().offset(margin.dynamic(1))
      $0.leading.equalToSuperview().offset(margin.dynamic(1))
    }
    
    imageView.snp.makeConstraints {
      $0.centerY.equalTo(titleLabel.snp.centerY)
      $0.trailing.equalToSuperview().offset(-margin.dynamic(1))
      $0.width.height.equalTo(margin.dynamic(4))
    }
    
    guideLabel.snp.makeConstraints {
      $0.top.equalTo(titleLabel.snp.bottom).offset(margin.dynamic(1))
      $0.leading.equalToSuperview().offset(margin.dynamic(1))
      $0.trailing.equalToSuperview().offset(-margin.dynamic(1))
      $0.height.equalTo(margin.dynamic(0.2))
    }
    
    dateLabel.snp.makeConstraints {
      $0.top.equalTo(guideLabel.snp.bottom).offset(margin.dynamic(1))
      $0.leading.equalToSuperview().offset(margin.dynamic(1))
    }
    
    pointLabel.snp.makeConstraints {
      $0.top.equalTo(guideLabel.snp.bottom).offset(margin.dynamic(1))
      $0.leading.equalTo(dateLabel.snp.trailing)
      $0.trailing.equalToSuperview().offset(-margin.dynamic(1))
      $0.width.equalTo(dateLabel.snp.width)
    }
    
    contentsLabel.snp.makeConstraints {
      $0.top.equalTo(dateLabel.snp.bottom).offset(margin.dynamic(2))
      $0.leading.equalToSuperview().offset(margin.dynamic(1))
      $0.bottom.equalToSuperview().offset(-margin.dynamic(2))
    }
    
    progressLabel.snp.makeConstraints {
      $0.top.equalTo(dateLabel.snp.bottom).offset(margin.dynamic(2))
      $0.leading.equalTo(contentsLabel.snp.trailing)
      $0.centerY.equalTo(contentsLabel.snp.centerY)
      $0.trailing.equalToSuperview().offset(-margin.dynamic(2))
      $0.bottom.equalToSuperview().offset(-margin.dynamic(2))
      $0.width.equalTo(contentsLabel.snp.width).multipliedBy(0.5)
    }
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

// MARK:- CLLocationManagerDelegate Extension
extension MapView: CLLocationManagerDelegate {
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    if let coor = manager.location?.coordinate {
      currentCoordinateValue = coor
    }
  }
}
