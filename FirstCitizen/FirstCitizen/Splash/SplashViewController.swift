//
//  SplashViewController.swift
//  FirstCitizen
//
//  Created by Fury on 25/09/2019.
//  Copyright © 2019 Kira. All rights reserved.
//

import UIKit
import MapKit

class SplashViewController: UIViewController {
  
  private let categoryShared = CategoryDataManager.shared
  private let incidentShared = IncidentDataManager.shared
  
  private var currentCoordinateValue: CLLocationCoordinate2D?
  let locationManager = CLLocationManager()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    
    locationManager.delegate = self
    getUserInfo()
    getLocationPermission()
  }
  
  private func getUserInfo() {
    guard let _ = UserDefaults.standard.string(forKey: "Token") else { return }
    
    NetworkService.getUserInfo { result in
      switch result {
      case .success(let data):
        let shared = UserInfoManager.shared
        shared.userInfo = data
      case .failure(let err):
        print(err.localizedDescription)
      }
    }
  }
  
  private func getCategoryList() {
    NetworkService.getCategoryList { [unowned self] result in
      switch result {
      case .success(let data):
        self.categoryShared.categoryData = data
        self.getIncidentDatas()
      case .failure(let err):
        print(err.localizedDescription)
      }
    }
  }
  
  private func getIncidentDatas() {
    guard let latitude = currentCoordinateValue?.latitude,
      let longitude = currentCoordinateValue?.longitude else {
        return }
    
    NetworkService.getHomeIncidentData(latitude: latitude, longitude: longitude) { result in
      switch result {
      case .success(let data):
        self.incidentShared.incidentDatas = data
        let mainTabBarVC = MainTabBarController()
        DispatchQueue.main.async {
          self.present(mainTabBarVC, animated: false, completion: nil)
        }
        
      case .failure(let err):
        // MARK: - 우선 실행은 가능하도록 함!!!
        let mainTabBarVC = MainTabBarController()
        DispatchQueue.main.async {
          self.present(mainTabBarVC, animated: false, completion: nil)
        }
        print(err.localizedDescription)
      }
    }
  }
  
  private func getLocationPermission() {
    // 권한 요청
    locationManager.requestWhenInUseAuthorization()
    locationManager.desiredAccuracy = kCLLocationAccuracyBest
    locationManager.startUpdatingLocation()
  }
}

extension SplashViewController: CLLocationManagerDelegate {
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    if let coor = manager.location?.coordinate {
      
      
      currentCoordinateValue = coor
    }
  }
  
  func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
    print("location manager authorization status changed")
    
    switch status {
    case .authorizedAlways:
      print("user allow app to get location data when app is active or in background")
    case .authorizedWhenInUse:
      print("user allow app to get location data only when app is active")
      getCategoryList()
      break
    case .denied:
      print("user tap 'disallow' on the permission dialog, cant get location data")
    case .restricted:
      print("parental control setting disallow location data")
    case .notDetermined:
      print("the location permission dialog haven't shown before, user haven't tap allow/disallow")
    @unknown default:
      fatalError()
    }
  }
}
