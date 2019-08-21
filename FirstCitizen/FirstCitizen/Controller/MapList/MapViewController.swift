//
//  MapViewController.swift
//  FirstCitizen
//
//  Created by Lee on 20/08/2019.
//  Copyright © 2019 Kira. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
  
  private let vMap = MapView()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    configure()
    autoLayout()
  }
  
  private func configure() {
    view.backgroundColor = .white
    
    vMap.mapView.delegate = self
    view.addSubview(vMap)
  }
  
  private struct Standard {
    static let space: CGFloat = 8
    
  }
  
  private func autoLayout() {
    vMap.translatesAutoresizingMaskIntoConstraints = false
    vMap.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
    vMap.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
    vMap.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    vMap.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -TabBarButtonView.height).isActive = true
  }
}

extension MapViewController: MKMapViewDelegate {
  func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
    
  }
}
