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
    let camera = MKMapCamera()
    camera.centerCoordinate = CLLocationCoordinate2D(latitude: 37.543952, longitude: 127.061270)
    camera.altitude = 300 // 고도 (미터단위)
    camera.pitch = 70.0 // 각도 (0일 때 수직)
    mapView.setCamera(camera, animated: true)
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
