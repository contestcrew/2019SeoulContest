//
//  MapView.swift
//  FirstCitizen
//
//  Created by Lee on 20/08/2019.
//  Copyright © 2019 Kira. All rights reserved.
//

import UIKit
import MapKit

class MapView: UIView {
  
  private let locationManager = CLLocationManager()

  let camera = MKMapCamera()
  let mapView = MKMapView()
  private let gradientView = UIImageView()
  
  private let imageView = UIImageView()
  private let titleLabel = UILabel()
  private let guideLabel = UILabel()
  private let dateLabel = UILabel()
  private let subLabel = UILabel()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    configure()
    autoLayout()
    mapSetting()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  
  
  private func configure() {
    self.addSubview(mapView)
    
    gradientView.image = UIImage(named: "Gradient")
    gradientView.contentMode = .scaleToFill
    self.addSubview(gradientView)
    
    imageView.backgroundColor = .red
    imageView.isHidden = true
    imageView.contentMode = .scaleAspectFit
    imageView.layer.cornerRadius = Standard.imageSize / 2
    self.addSubview(imageView)
    
    titleLabel.upsFontHeavy(ofSize: 35)
    self.addSubview(titleLabel)
    
    guideLabel.isHidden = true
    guideLabel.backgroundColor = .black
    self.addSubview(guideLabel)
    
    dateLabel.upsFontHeavy(ofSize: 15)
    self.addSubview(dateLabel)
    
    subLabel.upsFont(ofSize: 15)
    subLabel.textColor = .lightGray
    subLabel.numberOfLines = 0
    self.addSubview(subLabel)
  }
  
  private func mapSetting() {
    locationManager.delegate = self
    checkAuthorizationStatus()
    
    
//    camera.centerCoordinate = CLLocationCoordinate2D(latitude: 37.543952, longitude: 127.061270)
    camera.altitude = 300 // 고도 (미터단위)
    camera.pitch = 70.0 // 각도 (0일 때 수직)
    mapView.setCamera(camera, animated: true)
    mapView.showsUserLocation = true
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
    mapView.translatesAutoresizingMaskIntoConstraints = false
    mapView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
    mapView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
    mapView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    mapView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.75).isActive = true
    
    gradientView.translatesAutoresizingMaskIntoConstraints = false
    gradientView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
    gradientView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    gradientView.bottomAnchor.constraint(equalTo: mapView.bottomAnchor).isActive = true
  }
  
  
  
  
  
  
}


extension MapView: CLLocationManagerDelegate {
  func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
    print("\n----- [ status ] -----\n")
    switch status {
    case .authorizedAlways, .authorizedWhenInUse:
      print("Authorized")
    default:
      print("Unauthorized")
    }
  }
  
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    let current = locations.last! // 반드시 하나의 값은 들어오기 때문에 강제 바인딩
    
    if (abs(current.timestamp.timeIntervalSinceNow) < 10) {
      let coordinate = current.coordinate
      // span 단위는 1도, 경도 1도는 약 111킬로미터
      // 위도 1도는 위도에 따라 변함, 적도 (약 111km) ~ 극지방 (0km)
      let span = MKCoordinateSpan(latitudeDelta: 0.001, longitudeDelta: 0.001)
      // param의 수가 클수록 지도가 멀어짐
      
      let region = MKCoordinateRegion(center: coordinate, span: span)
      mapView.setRegion(region, animated: true)
      
//      addAnotation(location: current)
      camera.centerCoordinate = coordinate
//      camera.pitch = 70.0
//      camera.altitude = 300 // 고도 (미터단위)
      mapView.setCamera(camera, animated: true)
    }
  }
  
  func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    if let error = error as? CLError, error.code == .denied {
      // Location updates are no authorized.
      print("Location updates are no authorized.")
      return
    }
    // Notify the user of any error.
    print("Error reason: ", error.localizedDescription)
  }
}
