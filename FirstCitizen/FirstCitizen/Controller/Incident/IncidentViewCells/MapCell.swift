//
//  MapCell.swift
//  FirstCitizen
//
//  Created by Fury on 24/09/2019.
//  Copyright © 2019 Kira. All rights reserved.
//

import UIKit
import NMapsMap

class MapCell: UITableViewCell {
  
  static let identifier = "MapCell"
  
  private let nmapView = NMFMapView(frame: .zero)
  private let gradientView = UIImageView()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    attribute()
    layout()
  }
  
  func modifyProperties(_ latitude: Double?, _ longitude: Double?, pinImageUrlStr: String) {
    let pinImageURL: URL = URL(string: pinImageUrlStr)!
    
    let task = URLSession.shared.dataTask(with: pinImageURL) { (data, response, error) in
      guard error == nil else { return print(error!) }
      guard let response = response as? HTTPURLResponse,
        // ~= 범위 사이에 있는지 확인하는 것
        200..<400 ~= response.statusCode
        else { return print("StatusCode is not valid") }
      guard let data = data else { return }
      let iconImg = UIImage(data: data)
      
      guard let lat = latitude, let lng = longitude else { return }
      
      let marker = NMFMarker(position: NMGLatLng(lat: lat, lng: lng), iconImage: NMFOverlayImage(image: iconImg!))
      let markerWidth: CGFloat = 40
      let markerHeight: CGFloat = 50
      marker.width = markerWidth.dynamic(1)
      marker.height = markerHeight.dynamic(1)
      
      DispatchQueue.main.async {
        marker.mapView = self.nmapView
        let cameraUpdate = NMFCameraUpdate(scrollTo: NMGLatLng(lat: lat, lng: lng))
        cameraUpdate.animation = .easeIn
        self.nmapView.moveCamera(cameraUpdate)
      }
    }
    
    task.resume()
  }
  
  private func attribute() {
    nmapView.mapType = .basic
    nmapView.logoAlign = .rightTop
    nmapView.logoMargin = UIEdgeInsets(top: 60, left: 0, bottom: 0, right: 0)
    nmapView.minZoomLevel = 15
    
    gradientView.image = UIImage(named: "Gradient")
    gradientView.contentMode = .scaleToFill
  }
  
  private func layout() {
    let margin: CGFloat = 10
    
    [nmapView, gradientView]
      .forEach { contentView.addSubview($0) }
    
    nmapView.snp.makeConstraints {
      $0.top.leading.trailing.bottom.equalTo(contentView)
      $0.height.equalTo(UIScreen.main.bounds.height / 2)
    }
    
    gradientView.snp.makeConstraints {
      $0.leading.trailing.equalTo(contentView)
      $0.bottom.equalTo(nmapView.snp.bottom)
      $0.height.equalTo(margin.dynamic(10))
    }
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
