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
  
  // MARK:- Properties
  //TODO: Api를 통해서 카테고리 리스트를 가저올 예정
  private let sampleCategoryList = ["전체", "똥휴지", "사고", "실종", "분실"]
  
  private let vMap = MapView()
  private var selectedDataID = 0
  private var selectedDataCategory = ""
  
  // MARK:- LifeCycles
  override func viewDidLoad() {
    super.viewDidLoad()
    
    dataParsing(datas: sampleDatas)
//    testFunc()
    configure()
//    testFunc()
    
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()

    autoLayout()
  }
  
  // MARK:- Methods
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
    let margin: CGFloat = 10
    
    vMap.snp.makeConstraints {
      $0.top.leading.trailing.equalToSuperview()
      $0.bottom.equalToSuperview().offset(-TabBarButtonView.height - safeBottmHeight - margin.dynamic(1))
    }
  }
  
  // MapViewController의 뿌려줄 Data를 파싱하는 역할을 함
  private func dataParsing(datas: [Data]) {
    var tag = 0
    datas.forEach {
      if let incidentData = try? JSONDecoder().decode(HomeIncidentData.self, from: $0) {
        resizeIcons(data: incidentData, tag: tag)
      }
      tag += 1
    }
  }
  
  // 파싱한 데이터들 중 Pin Icon의 사이즈를 조정하는 역할을 함
  private func resizeIcons(data: HomeIncidentData, tag: Int) {
    // ToDo 이미지 캐시처리가 필요함
    let iconImg = UIImage(named: "Pin\(data.category)")
    iconImg?.resize(scale: 0.3, completion: {
      self.showMarkers(img: $0 ?? UIImage(named: "Missing")!, data: data, tag: tag)
    })
  }
  
  // 파싱한 데이터들의 Marker를 찍는 역할을 함
  private func showMarkers(img: UIImage, data: HomeIncidentData, tag: Int) {
    let lat = Double(data.coordinate.first ?? 0)
    let lng = Double(data.coordinate.last ?? 0)
    
    let marker = NMFMarker(position: NMGLatLng(lat: lat, lng: lng), iconImage: NMFOverlayImage(image: img))
    
    // NMFOverlayTouchHandler를 설정함 (Pin Touch 이벤트를 작성)
    let handler: NMFOverlayTouchHandler = { [weak self] overlay in
      
      self?.pinClickAnimation()
      self?.vMap.changePreviewContainer(data)
      self?.selectedDataID = data.id
      self?.selectedDataCategory = data.category
      
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
    UIAlertController.registerShow(categoryList: sampleCategoryList, title: "의뢰하기", message: "아래 목록중 하나를 선택하세요", from: self)
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
