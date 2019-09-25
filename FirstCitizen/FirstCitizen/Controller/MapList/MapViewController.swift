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
  
  private let vMap = MapView()
  private var selectedDataID = 0
  private var selectedDataCategory = ""
  
  // MARK:- LifeCycles
  override func viewDidLoad() {
    super.viewDidLoad()
    
    attribute()
    extractCategory()
    
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    
    layout()
    displayDatasInMap()
  }
  
  // MARK:- Methods
  // 카테고리 이름만 추출하여 categoryList 배열에 저장
  private func extractCategory() {
    let categoryData = categoryShared.categoryData
    
    categoryList = categoryData.map { $0.name }
  }
  
  private func displayDatasInMap() {
    guard let homeIncidentDatas = homeIncidentShared.incidentDatas else { return }
    
    if homeIncidentDatas.count != 0 {
      vMap.changePreviewContainer(homeIncidentDatas[0])
    }
    
    var tag = 0
    homeIncidentDatas.forEach {
      resizeIcons(incidentData: $0, tag: tag)
      tag += 1
    }
  }
  
  // 파싱한 데이터들 중 Pin Icon의 사이즈를 조정하는 역할을 함
  private func resizeIcons(incidentData: IncidentData, tag: Int) {
    // ToDo 이미지 캐시처리가 필요함
    //    print("[Log] data.category :", incidentData.category)
    //    print("[Log] categoryList :", categoryShared.categoryData[incidentData.category])
    //    print("")
    //    print("")
    
    
    //    let imageUrlStr: String = categoryShared.categoryData[incidentData.category].image
    //    let imageURL: URL = URL(string: imageUrlStr)!
    //
    //    URLSession.shared.dataTask(with: imageURL) { (data, resonse, error) in
    //      let iconImg = UIImage(data: data!)
    //      iconImg?.resize(scale: 0.3, completion: {
    //        self.showMarkers(img: $0 ?? UIImage(named: "Missing")!, data: incidentData, tag: tag)
    //      })
    //    }
    
    let iconImg = UIImage(named: "PinMissing")
    iconImg?.resize(scale: 0.3, completion: {
      self.showMarkers(img: $0 ?? UIImage(named: "Missing")!, data: incidentData, tag: tag)
    })
  }
  
  // 파싱한 데이터들의 Marker를 찍는 역할을 함
  private func showMarkers(img: UIImage, data: IncidentData, tag: Int) {
    let lat = data.latitude
    let lng = data.longitude
    
    let marker = NMFMarker(position: NMGLatLng(lat: lat, lng: lng), iconImage: NMFOverlayImage(image: img))
    
    // NMFOverlayTouchHandler를 설정함 (Pin Touch 이벤트를 작성)
    let handler: NMFOverlayTouchHandler = { [weak self] overlay in
      
      self?.pinClickAnimation()
      self?.vMap.changePreviewContainer(data)
      self?.selectedDataID = data.id
      //      self?.selectedDataCategory = data.category
      
      // 핀을 누른 위치로 카메라를 이동
      let cameraUpdate = NMFCameraUpdate(scrollTo: marker.position)
      cameraUpdate.animation = .easeIn
      self?.vMap.nMapView.mapView.moveCamera(cameraUpdate)
      
      return true
    }
    
    marker.captionPerspectiveEnabled = true
    marker.iconPerspectiveEnabled = true
    marker.isHideCollidedSymbols = true
    
    marker.userInfo = ["tag": tag]
    
    marker.mapView = vMap.nMapView.mapView
    marker.touchHandler = handler
  }
  
  // 핀을 클릭했을 때 동작하는 애니메이션
  private func pinClickAnimation() {
    
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

// MARK:- MKMapVieDelegate Extension
extension MapViewController: MKMapViewDelegate {
  func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
    
  }
}

// MARK:- MapViewDelegate Extension
extension MapViewController: MapViewDelegate {
  // 의뢰하기 버튼을 눌렀을 때 의뢰하기 VC를 띄우는 역할을 함
  func touchUpRegisterButton() {
    UIAlertController.registerShow(categoryList: categoryList, title: "의뢰하기", message: "아래 목록중 하나를 선택하세요", from: self)
  }
  
  // Preview를 클릭했을 때, 상세 화면으로 이동하는 역할을 함
  func touchUpPreview() {
    let incidentVC = IncidentViewController()
    
    //TODO: Category 동적으로 넣어줘야 함 -> 뷰 생성을 위한 Category 입력임(카테고리별로 뷰가 다름)
    //TODO: Incident Detail Data 호출해야함!! (selectedID 값 이용) -> 호출한 데이터의 category를 넣어주면 됌
    incidentVC.category = selectedDataCategory
    self.present(incidentVC, animated: true, completion: nil)
  }
  
  // 현재 위치로 이동하는 역할을 함
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
