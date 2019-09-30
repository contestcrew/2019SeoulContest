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
import Kingfisher

class MapViewController: UIViewController {
  
  // MARK:- Properties
  let homeIncidentShared = IncidentDataManager.shared
  let categoryShared = CategoryDataManager.shared
  
  private var categoryList: [String] = []
  private var iconImgDic: [Int: UIImage] = [:]
  private var pinIconImgDic: [Int: UIImage] = [:]
  private var selectedIncidentData: IncidentData?
  
  private let vMap = MapView()
  
  // MARK:- LifeCycles
  override func viewDidLoad() {
    super.viewDidLoad()
    
    extractCategory()
    attribute()
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    
    showMarkers()
    layout()
  }
  
  // MARK:- Methods
  // 카테고리 이름만 추출하여 categoryList 배열에 저장
  private func extractCategory() {
    let categoryData = categoryShared.categoryData
    let semaphore = DispatchSemaphore(value: 0)
    
    categoryList = categoryData.map { $0.name }
    
    // icon 이미지 최초 다운로드
    categoryData.forEach {
      if iconImgDic[$0.id] == nil {
        let imageURL: URL = URL(string: $0.image)!
        let id = $0.id
        
        let task = URLSession.shared.dataTask(with: imageURL) { (data, response, error) in
          guard error == nil else { return print(error!) }
          guard let response = response as? HTTPURLResponse,
            // ~= 범위 사이에 있는지 확인하는 것
            200..<400 ~= response.statusCode
            else { return print("StatusCode is not valid") }
          guard let data = data else { return }
          semaphore.signal()
          self.iconImgDic[id] = UIImage(data: data)
        }
        task.resume()
        semaphore.wait()
      }
    }
    
    // pin 이미지 최초 다운로드
    categoryData.forEach {
      if self.pinIconImgDic[$0.id] == nil {
        let imageURL: URL = URL(string: $0.pinImage)!
        let id = $0.id
        
        let task2 = URLSession.shared.dataTask(with: imageURL) { (data, response, error) in
          guard error == nil else { return print(error!) }
          guard let response = response as? HTTPURLResponse,
            // ~= 범위 사이에 있는지 확인하는 것
            200..<400 ~= response.statusCode
            else { return print("StatusCode is not valid") }
          guard let data = data else { return }
          semaphore.signal()
          self.pinIconImgDic[id] = UIImage(data: data)
        }
        
        task2.resume()
        semaphore.wait()
      }
    }
  }
  
  // 파싱한 데이터들의 Marker를 찍는 역할을 함
  private func showMarkers() {
    guard let homeIncidentDatas = homeIncidentShared.incidentDatas else { return }
    
    var markers = [NMFMarker]()
    var markersImgDic = [Int: NMFOverlayImage]()
    
    // 핀 이미지가 들어간 NMFOverlayImage 생성
    self.pinIconImgDic.forEach {
      let key = $0.key
      if markersImgDic[key] == nil {
        markersImgDic[key] = NMFOverlayImage(image: $0.value)
      }
    }
    
    DispatchQueue.global(qos: .default).async {
      homeIncidentDatas.forEach {
        let currentIncidentData = $0
        let lat = $0.latitude ?? 0
        let lng = $0.longitude ?? 0
        
        let marker = NMFMarker(position: NMGLatLng(lat: lat, lng: lng), iconImage: markersImgDic[$0.category]!)
        marker.captionPerspectiveEnabled = true
        marker.iconPerspectiveEnabled = true
        marker.isHideCollidedSymbols = true
        marker.isForceShowIcon = true
        let markerWidth: CGFloat = 40
        let markerHeight: CGFloat = 50
        marker.width = markerWidth.dynamic(1)
        marker.height = markerHeight.dynamic(1)
        
        // NMFOverlayTouchHandler를 설정함 (Pin Touch 이벤트를 작성)
        let handler: NMFOverlayTouchHandler = { [weak self] overlay in
          // 핀을 누른 위치로 카메라를 이동
          let cameraUpdate = NMFCameraUpdate(scrollTo: marker.position)
          cameraUpdate.animation = .easeIn
          self?.vMap.nMapView.mapView.moveCamera(cameraUpdate)
          let categoryImg = self?.iconImgDic[currentIncidentData.category]
          self?.selectedIncidentData = currentIncidentData
          self?.vMap.changePreviewContainer(currentIncidentData, categoryImg!)
          
          self?.vMap.previewContainer.isHidden = false
          self?.vMap.firstExplainLabel.isHidden = true
          return true
        }
        marker.touchHandler = handler
        markers.append(marker)
      }
      
      DispatchQueue.main.async { [weak self] in
        for marker in markers {
          marker.mapView = self?.vMap.nMapView.mapView
        }
      }
    }
  }
  
  private func getCategoryList() {
    NetworkService.getCategoryList { [unowned self] result in
      switch result {
      case .success(let data):
        self.categoryShared.categoryData = data
      case .failure(let err):
        print(err.localizedDescription)
      }
    }
  }
  
  private func getIncidentDatas(lat: Double, lng: Double) {
    NetworkService.getHomeIncidentData(latitude: lat, longitude: lng) { result in
      switch result {
      case .success(let data):
        self.homeIncidentShared.incidentDatas = data
      case .failure(let err):
        print(err.localizedDescription)
      }
    }
  }
  
  private func attribute() {
    self.view.backgroundColor = .white
    vMap.delegate = self
  }
  
  private struct Standard {
    static let space: CGFloat = 8
  }
  
  private func layout() {
    let safeBottmHeight = view.safeAreaInsets.bottom
    let margin: CGFloat = 10
    
    view.addSubview(vMap)
    
    vMap.snp.makeConstraints {
      $0.top.leading.trailing.equalToSuperview()
      $0.bottom.equalToSuperview().offset(-TabBarButtonView.height - safeBottmHeight - margin.dynamic(1))
    }
  }
}

// MARK:- MapViewDelegate Extension
extension MapViewController: MapViewDelegate {
  func touchUpRefreshButton(coordinate: CLLocationCoordinate2D) {
    DispatchQueue.main.async {
      self.getCategoryList()
      self.getIncidentDatas(lat: coordinate.latitude, lng: coordinate.longitude)
      self.extractCategory()
      self.showMarkers()
      self.touchUpLocationButton(coordinate: coordinate)
      self.view.layoutIfNeeded()
    }
  }
  
  // 의뢰하기 버튼을 눌렀을 때 의뢰하기 VC를 띄우는 역할을 함
  func touchUpRegisterButton() {
    UIAlertController.registerShowMap(categoryList: categoryList, title: "의뢰하기", message: "아래 목록중 하나를 선택하세요", from: self)
  }
  
  // Preview를 클릭했을 때, 상세 화면으로 이동하는 역할을 함
  func touchUpPreview() {
    let incidentVC = IncidentViewController()
    if homeIncidentShared.incidentDatas?.count == 0 { return }
    
    incidentVC.category = categoryList[(selectedIncidentData?.category)! - 1]
    incidentVC.detailIncidentData = selectedIncidentData
    
    self.present(incidentVC, animated: true, completion: nil)
  }
  
  // 현재 위치로 이동하는 역할을 함
  func touchUpLocationButton(coordinate: CLLocationCoordinate2D) {
    let cameraUpdate = NMFCameraUpdate(scrollTo: NMGLatLng(lat: coordinate.latitude, lng: coordinate.longitude))
    cameraUpdate.animation = .easeIn
    vMap.nMapView.mapView.moveCamera(cameraUpdate)
  }
}
