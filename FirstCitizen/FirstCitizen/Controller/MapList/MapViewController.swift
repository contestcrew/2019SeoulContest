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
  
  // MARK:- Properties
  let homeIncidentShared = IncidentDataManager.shared
  let categoryShared = CategoryDataManager.shared
  
  private var categoryList: [String] = []
  private var selectedIncidentData: IncidentData?
  
  private let vMap = MapView()
  
  // MARK:- LifeCycles
  override func viewDidLoad() {
    super.viewDidLoad()

    attribute()
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    
    extractCategory()
    displayDatasInMap()
    layout()
    vMap.layoutIfNeeded()
  }
  
  // MARK:- Methods
  // 카테고리 이름만 추출하여 categoryList 배열에 저장
  private func extractCategory() {
    let categoryData = categoryShared.categoryData
    
    categoryList = categoryData.map { $0.name }
  }
  
  private func showFirstData() {
    
    //TODO: 카테고리 데이터가 없을 경우 빈 화면을 보여주는 뷰를 그릴 예정
    guard let selectedIncidentData = selectedIncidentData else { return }
    
    let categoryImg = categoryShared.categoryData[selectedIncidentData.category - 1].image
    DispatchQueue.main.async {
      self.vMap.changePreviewContainer(self.selectedIncidentData!, categoryImg)
    }
  }
  
  private func displayDatasInMap() {
    guard let homeIncidentDatas = homeIncidentShared.incidentDatas else { return }
    if homeIncidentDatas.count != 0 {
      selectedIncidentData = homeIncidentDatas[0]
    }
    
    var tag = 0
    homeIncidentDatas.forEach {
      getIconImage(incidentData: $0, tag: tag)
      tag += 1
    }
  }
  
  // icon image url로 이미지를 가져오는 함수
  private func getIconImage(incidentData: IncidentData, tag: Int) {
    // ToDo 이미지 캐시처리가 필요함
    
    var imageUrlStr: String = ""
    
    categoryShared.categoryData.forEach {
      if $0.id == incidentData.category {
        imageUrlStr = $0.pinImage
      }
    }
    
    let imageURL: URL = URL(string: imageUrlStr)!
    
    let task = URLSession.shared.dataTask(with: imageURL) { (data, response, error) in
      guard error == nil else { return print(error!) }
      guard let response = response as? HTTPURLResponse,
        // ~= 범위 사이에 있는지 확인하는 것
        200..<400 ~= response.statusCode
        else { return print("StatusCode is not valid") }
      guard let data = data else { return }
      let iconImg = UIImage(data: data)
      self.showMarkers(img: iconImg!, data: incidentData, tag: tag)
    }
    
    task.resume()
  }
  
  // 파싱한 데이터들의 Marker를 찍는 역할을 함
  private func showMarkers(img: UIImage, data: IncidentData, tag: Int) {
    let lat = data.latitude
    let lng = data.longitude
    
    DispatchQueue.main.async {
      let marker = NMFMarker(position: NMGLatLng(lat: lat, lng: lng), iconImage: NMFOverlayImage(image: img))
      marker.isForceShowIcon = true
      
      // NMFOverlayTouchHandler를 설정함 (Pin Touch 이벤트를 작성)
      let handler: NMFOverlayTouchHandler = { [weak self] overlay in
        // 핀을 누른 위치로 카메라를 이동
        let cameraUpdate = NMFCameraUpdate(scrollTo: marker.position)
        cameraUpdate.animation = .easeIn
        self?.vMap.nMapView.mapView.moveCamera(cameraUpdate)
        let categoryImg = self!.categoryShared.categoryData[data.category - 1].image
        self?.vMap.changePreviewContainer(data, categoryImg)
        self?.selectedIncidentData = data
        self?.vMap.previewContainer.isHidden = false
        self?.vMap.firstExplainLabel.isHidden = true
        return true
      }
      
      marker.captionPerspectiveEnabled = true
      marker.iconPerspectiveEnabled = true
      marker.isHideCollidedSymbols = true
      marker.touchHandler = handler
      marker.userInfo = ["tag": tag]
      
      let markerWidth: CGFloat = 40
      let markerHeight: CGFloat = 50
      marker.width = markerWidth.dynamic(1)
      marker.height = markerHeight.dynamic(1)
      
      marker.mapView = self.vMap.nMapView.mapView
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
