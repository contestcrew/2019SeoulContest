//
//  LocationWithMap.swift
//  FirstCitizen
//
//  Created by hyeoktae kwon on 2019/09/25.
//  Copyright © 2019 Kira. All rights reserved.
//

import UIKit
import NMapsMap
import MapKit
import SnapKit
import Alamofire

class LocationWithMap: UIViewController {
  
  let selectBtn: UIButton = {
    let btn = UIButton()
    btn.setTitle("현재주소 입력", for: .normal)
    btn.backgroundColor = .appColor(.appButtonColor)
    btn.layer.cornerRadius = 15
    return btn
  }()
  
  let addressLabel: UILabel = {
    let label = UILabel()
    label.backgroundColor = .appColor(.appLayerBorderColor)
    label.alpha = 0.8
    label.text = "현재 주소"
    label.layer.cornerRadius = 30
    label.textAlignment = .center
    label.textColor = .black
    return label
  }()
  
  var marker = NMFMarker()
  let markerImg = NMFOverlayImage(name: "PinLocation", reuseIdentifier: "PinLocation")
  
  let nMapLocationManager = NMFLocationManager()
  let nMapView = NMFNaverMapView(frame: UIScreen.main.bounds)
  private let locationManager = CLLocationManager()
  let geocoder = CLGeocoder()
//  var currentCoordinateValue: CLLocationCoordinate2D?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = .gray
    locationManager.delegate = self
    marker.iconImage = markerImg
    setupNavigation()
    checkAuthorizationStatus()
    nMapConfigure()
    setupLayout()
    
  }
  
  func pointToAdd(location: NMGLatLng, completion: @escaping (String) -> ()) {
    let location = CLLocation(latitude: location.lat, longitude: location.lng)
    geocoder.reverseGeocodeLocation(location) {
      guard $1 == nil else {
        completion("위치 주소 찾을 수 없음")
        return }
      guard let address = $0?.first,
      let country = address.country,
      let administrativeArea = address.administrativeArea,
      let locality = address.locality,
      let name = address.name
      else {
        completion("위치 주소 찾을 수 없음")
        return }
      let add = "\(country) \(administrativeArea) \(locality) \(name)"
      completion(add)
    }
  }
  
  func replaceCenterIcon(location: NMGLatLng) {
    let markerWidth: CGFloat = 40
    let markerHeight: CGFloat = 50
    
    marker.position = location
    
    marker.isForceShowIcon = true
    marker.captionPerspectiveEnabled = true
    marker.iconPerspectiveEnabled = true
    marker.isHideCollidedSymbols = true
    
    marker.width = markerWidth.dynamic(1)
    marker.height = markerHeight.dynamic(1)
    
    DispatchQueue.main.async {
      self.marker.mapView = self.nMapView.mapView
    }
  }
  
  func nMapConfigure() {
    nMapView.mapView.mapType = .basic
    nMapView.mapView.logoAlign = .leftTop
    nMapView.positionMode = .direction
    nMapView.showLocationButton = false
    nMapView.showZoomControls = false
    nMapView.showCompass = false
    nMapView.showScaleBar = false
    nMapView.mapView.minZoomLevel = 15
    nMapView.delegate = self
    
  }
  
  func setupLayout() {
    [nMapView, selectBtn, addressLabel].forEach { self.view.addSubview($0) }
    
    selectBtn.snp.makeConstraints {
      $0.trailing.bottom.equalToSuperview().offset(-30)
      $0.leading.equalToSuperview().offset(30)
    }
    
    addressLabel.snp.makeConstraints {
      $0.leading.trailing.equalTo(selectBtn)
      $0.bottom.equalTo(selectBtn.snp.top).offset(-30)
    }
    
    view.bringSubviewToFront(selectBtn)
    view.bringSubviewToFront(addressLabel)
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
    navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
    navigationController?.navigationBar.shadowImage = UIImage()
    navigationController?.navigationBar.isTranslucent = true
    navigationController?.navigationBar.tintColor = .appColor(.appLayerBorderColor)
  }
  
}

// MARK:- CLLocationManagerDelegate Extension
extension LocationWithMap: CLLocationManagerDelegate {
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    if let coor = manager.location?.coordinate {
//      currentCoordinateValue = coor
      replaceCenterIcon(location: NMGLatLng(from: coor))
    }
  }
}

extension LocationWithMap: NMFMapViewDelegate {
  func mapViewIdle(_ mapView: NMFMapView) {
    // 지도 탭 이벤트가 끝났을때 호출
    replaceCenterIcon(location: mapView.cameraPosition.target)
    pointToAdd(location: mapView.cameraPosition.target) { add in
      DispatchQueue.main.async {
        self.addressLabel.text = add
      }
    }
  }
  
  func mapView(_ mapView: NMFMapView, regionWillChangeAnimated animated: Bool, byReason reason: Int) {
    replaceCenterIcon(location: mapView.cameraPosition.target)
  }
}
