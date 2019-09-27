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

class LocationWithMap: UIViewController {
  
  let nMapLocationManager = NMFLocationManager()
  let nMapView = NMFNaverMapView(frame: UIScreen.main.bounds)
  private let locationManager = CLLocationManager()
  var currentCoordinateValue: CLLocationCoordinate2D?
//  let camera = MKMapCamera()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = .gray
    locationManager.delegate = self
    setupNavigation()
    checkAuthorizationStatus()
    nMapConfigure()
    setupLayout()
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
  }
  
  func setupLayout() {
    [nMapView].forEach { self.view.addSubview($0) }
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
      currentCoordinateValue = coor
    }
  }
}
