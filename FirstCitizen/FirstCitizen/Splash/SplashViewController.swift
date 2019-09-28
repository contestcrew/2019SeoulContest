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
    
    getLocationPermission()
    getCategoryList()
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
          self.present(mainTabBarVC, animated: true, completion: nil)
        }
        
      case .failure(let err):
        // MARK: - 우선 실행은 가능하도록 함!!!
        let mainTabBarVC = MainTabBarController()
        DispatchQueue.main.async {
          self.present(mainTabBarVC, animated: true, completion: nil)
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
}
