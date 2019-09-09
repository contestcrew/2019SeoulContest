//
//  RestroomView.swift
//  FirstCitizen
//
//  Created by Fury on 09/09/2019.
//  Copyright © 2019 Kira. All rights reserved.
//

import UIKit
import MapKit

class RestroomView: UIView {
  
  private let locationManager = CLLocationManager()
  
  let camera = MKMapCamera()
  let mapView = MKMapView()
  private let gradientView = UIImageView()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    attribute()
    layout()
  }
  
  private func attribute() {
    
  }
  
  private func layout() {
    [mapView, gradientView].forEach { self.addSubview($0) }
    mapView.snp.makeConstraints {
      $0.top.leading.trailing.equalToSuperview()
      $0.height.equalToSuperview().multipliedBy(0.4)
    }
    
    gradientView.snp.makeConstraints {
      $0.leading.trailing.equalToSuperview()
      $0.bottom.equalTo(mapView.snp.bottom)
    }
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
