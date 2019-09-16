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

class MapViewController: UIViewController {
  
  private let vMap = MapView()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    configure()
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    
    autoLayout()
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
