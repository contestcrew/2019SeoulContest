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

protocol MapViewDelegate: class {
  func setNMGLatLng(coordinate: CLLocationCoordinate2D)
  func touchUpLocationButton(coordinate: CLLocationCoordinate2D)
  func touchUpPreview()
  func touchUpRegisterButton()
}

class MapView: UIView {
  weak var delegate: MapViewDelegate?
  var currentCoordinateValue: CLLocationCoordinate2D?
  
  let nMapLocationManager = NMFLocationManager()
  let nMapView = NMFNaverMapView(frame: .zero)
  
  private let locationManager = CLLocationManager()
  
  let camera = MKMapCamera()
  
  private let gradientView = UIImageView()
  
  let previewContainer = UIView()
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
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    getCurrentLocation()
    autoLayout()
    mapSetting()
    nMapConfigure()
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    
    attribute()
  }
  
  func changePreviewContainer(_ homeIncidentData: HomeIncidentData) {
    titleLabel.text = homeIncidentData.title
    imageView.image = UIImage(named: homeIncidentData.category)
    dateLabel.text = homeIncidentData.uploadTime
    contentsLabel.text = homeIncidentData.contents
    pointLabel.text = "Point \(homeIncidentData.servicePoint) + Bonus \(homeIncidentData.userPoint)"
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
    // 권한 요청
    locationManager.requestWhenInUseAuthorization()
    locationManager.desiredAccuracy = kCLLocationAccuracyBest
    locationManager.startUpdatingLocation()
  }
  
  private func nMapConfigure() {
    nMapView.mapView.buildingHeight = 0.5
    nMapView.mapView.mapType = .basic
    nMapView.mapView.logoAlign = .leftTop
    nMapView.positionMode = .compass
    nMapView.showLocationButton = false
    nMapView.showZoomControls = false
    
    nMapView.showCompass = false
    nMapView.showScaleBar = false
    
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
  
  private func attribute() {
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
    imageView.image = #imageLiteral(resourceName: "Restroom")
    
    titleLabel.upsFontHeavy(ofSize: 26)
    titleLabel.text = "굳어가고 있어요 헬프미"
    titleLabel.adjustsFontSizeToFitWidth = true
    titleLabel.minimumScaleFactor = 0.4
    
    guideLabel.backgroundColor = .black
    
    dateLabel.upsFontHeavy(ofSize: 13)
    dateLabel.text = "2019-08-14 목요일"
    dateLabel.adjustsFontSizeToFitWidth = true
    dateLabel.minimumScaleFactor = 0.5
    
    pointLabel.text = "Point 100 + Bonus 350"
    pointLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    pointLabel.adjustsFontSizeToFitWidth = true
    pointLabel.minimumScaleFactor = 0.5
    pointLabel.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
    let attributedStr = NSMutableAttributedString(string: pointLabel.text!)
    attributedStr.addAttribute(.foregroundColor, value: UIColor.blue, range: (pointLabel.text! as NSString).range(of: "Bonus"))
    attributedStr.addAttribute(.foregroundColor, value: UIColor.orange, range: (pointLabel.text! as NSString).range(of: "Point"))
    pointLabel.attributedText = attributedStr
    
    contentsLabel.upsFontBold(ofSize: 15)
    contentsLabel.textColor = .darkGray
    contentsLabel.text = "굳어가고 있어요.. 헬퓨ㅡ미.."
    contentsLabel.adjustsFontSizeToFitWidth = true
    contentsLabel.minimumScaleFactor = 0.5
    
    progressLabel.upsFontHeavy(ofSize: 22)
    progressLabel.text = "도움요청중"
    progressLabel.textAlignment = .center
    progressLabel.adjustsFontSizeToFitWidth = true
    progressLabel.minimumScaleFactor = 0.5
    progressLabel.textColor = UIColor.appColor(.appGreenColor)
  }
  
  private func mapSetting() {
    checkAuthorizationStatus()
  }
  
  func checkAuthorizationStatus() {
    switch CLLocationManager.authorizationStatus() {
    case .notDetermined:
      locationManager.requestWhenInUseAuthorization()
    //             locationManager.requestAlwaysAuthorization()
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
    [nMapView, gradientView, previewContainer, locationButton, refreshButton, registerButton]
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
      $0.height.equalTo(100)
    }

    locationButton.snp.makeConstraints {
      $0.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(10)
      $0.trailing.equalTo(self).offset(-10)
      $0.width.height.equalTo(40)
    }

    refreshButton.snp.makeConstraints {
      $0.top.equalTo(locationButton.snp.bottom).offset(20)
      $0.trailing.equalTo(self).offset(-10)
      $0.width.height.equalTo(40)
    }

    registerButton.snp.makeConstraints {
      $0.top.equalTo(gradientView.snp.top)
      $0.trailing.equalTo(self).offset(-10)
      $0.width.height.equalTo(40)
    }

    previewContainer.snp.makeConstraints {
      $0.top.equalTo(gradientView.snp.bottom).offset(-10)
      $0.leading.equalTo(self).offset(10)
      $0.trailing.bottom.equalTo(self).offset(-10)
    }

    titleLabel.snp.makeConstraints {
      $0.top.equalToSuperview().offset(20)
      $0.leading.equalToSuperview().offset(10)
    }

    imageView.snp.makeConstraints {
      $0.centerY.equalTo(titleLabel.snp.centerY)
      $0.trailing.equalToSuperview().offset(-10)
      $0.width.height.equalTo(40)
    }

    guideLabel.snp.makeConstraints {
      $0.top.equalTo(titleLabel.snp.bottom).offset(20)
      $0.leading.equalToSuperview().offset(10)
      $0.trailing.equalToSuperview().offset(-10)
      $0.height.equalTo(2)
    }

    dateLabel.snp.makeConstraints {
      $0.top.equalTo(guideLabel.snp.bottom).offset(10)
      $0.leading.equalToSuperview().offset(10)
    }

    pointLabel.snp.makeConstraints {
      $0.top.equalTo(guideLabel.snp.bottom).offset(10)
      $0.trailing.equalToSuperview().offset(-10)
    }

    contentsLabel.snp.makeConstraints {
      $0.top.equalTo(dateLabel.snp.bottom).offset(20)
      $0.leading.equalToSuperview().offset(10)
    }

    progressLabel.snp.makeConstraints {
      $0.leading.equalTo(contentsLabel.snp.trailing)
      $0.centerY.equalTo(contentsLabel.snp.centerY)
      $0.trailing.equalToSuperview().offset(-20)
      $0.width.equalTo(contentsLabel.snp.width).multipliedBy(0.5)
    }
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension MapView: CLLocationManagerDelegate {
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    if let coor = manager.location?.coordinate {
      currentCoordinateValue = coor
    }
  }
}
