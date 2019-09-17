//
//  MapViewController.swift
//  FirstCitizen
//
//  Created by Lee on 20/08/2019.
//  Copyright © 2019 Kira. All rights reserved.
//

import UIKit
import MapKit
import NMapsMap
import Alamofire

class MapViewController: UIViewController {
  
  let sampleJsonData1 = """
{
"category": "Restroom",
"id": 1,
"coordinate": [37.555429, 126.859272],
"upload_time": "2019-05-06 목요일",
"service_point": 100,
"user_point": 50,
"title": "화장실 휴지좀..",
"contents": "어디 화장실인데 화장실 휴지가 너무 필요해요!! 빨리 부탁드려요!!"
}
""".data(using: .utf8)!
  
  private let vMap = MapView()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    testFunc()
    configure()
    testFunc()
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    
    autoLayout()
  }
  
  private func testFunc() {
    let decoder = JSONDecoder()
    if let sampleData1 = try? decoder.decode(HomeIncidentData.self, from: sampleJsonData1) {
      let marker = NMFMarker()
      marker.position = NMGLatLng(lat: Double(sampleData1.coordinate[0]), lng: Double(sampleData1.coordinate[1]))
      marker.mapView = vMap.nMapView.mapView
      
      let handler: NMFOverlayTouchHandler = { [unowned self] (overlay) -> Bool in
        self.vMap.changePreviewContainer(sampleData1)
        return false
      }
      
      marker.userInfo = ["tag": 0]
      
      marker.touchHandler = handler
    }
  }
  
  private func configure() {
    view.backgroundColor = .white
    
    vMap.delegate = self
  }
  
  private struct Standard {
    static let space: CGFloat = 8
    
  }
  
  private func autoLayout() {
    view.addSubview(vMap)
    let safeBottmHeight = view.safeAreaInsets.bottom
    vMap.snp.makeConstraints {
      $0.top.leading.trailing.bottom.equalToSuperview()
      $0.bottom.equalToSuperview().offset(-TabBarButtonView.height - safeBottmHeight)
    }
  }
}

extension MapViewController: MKMapViewDelegate {
  func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
    
  }
}

extension MapViewController: MapViewDelegate {
  func touchUpPreview() {
    let incidentVC = IncidentViewController()
    
    //TODO: Category 동적으로 넣어줘야 함
    //TODO: Incident Detail Data 호출해야함!!
    incidentVC.category = "Restroom"
    self.present(incidentVC, animated: true, completion: nil)
  }
  
  func touchUpLocationButton(coordinate: CLLocationCoordinate2D) {
    let cameraUpdate = NMFCameraUpdate(scrollTo: NMGLatLng(lat: coordinate.latitude, lng: coordinate.longitude))
    cameraUpdate.animation = .easeIn
    vMap.nMapView.mapView.moveCamera(cameraUpdate)
  }
  
  func setNMGLatLng(coordinate: CLLocationCoordinate2D) {
    
//    let locationOverlay = vMap.nMapView.locationOverlay
//    locationOverlay.location = NMGLatLng(lat: coordinate.latitude, lng: coordinate.longitude)
  }
}
