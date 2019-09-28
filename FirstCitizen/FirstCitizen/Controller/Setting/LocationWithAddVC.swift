//
//  LocationWithAddVC.swift
//  FirstCitizen
//
//  Created by Jeon-heaji on 28/09/2019.
//  Copyright © 2019 Kira. All rights reserved.
//
//
//import UIKit
//import NMapsMap
//import SnapKit
//
//
//class LocationWithAddVC: UIViewController {
//  
//  let searchTF: UITextField = {
//    let textfield = UITextField()
//    textfield.placeholder = "도로명, 건물명, 번지 검색"
//    textfield.borderStyle = .bezel
//    return textfield
//  }()
//  
//  let searchBtn: UIButton = {
//    let button = UIButton(type: .custom)
//    button.setImage(UIImage(named: "search"), for: .normal)
//    button.tintColor = .gray
//    return button
//  }()
//  
//  
//  let tipLabel: UILabel = {
//    let label = UILabel()
//    label.text = "우편번호 통합검색 Tip"
//    label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
//    return label
//  }()
//  
//  let streetLabel: UILabel = {
//    let label = UILabel()
//    let attributedString = NSMutableAttributedString()
//      .normal("∙도로명 + ", fontSize: 20)
//      .bold(" 건물번호", fontSize: 20)
//      .normal(" (예: 송파대로 570)", fontSize: 20)
//    label.attributedText = attributedString
//    return label
//  }()
//  
//  let townLabel: UILabel = {
//    let label = UILabel()
//    return label
//  }()
//  
//  let buildingLabel: UILabel = {
//    let label = UILabel()
//    return label
//  }()
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//      addSubViews()
//      setupSNP()
//      setupNavigation()
//      
//    }
//  
//  
//  private func addSubViews() {
//    [searchTF, searchBtn, tipLabel, streetLabel].forEach
//      { self.view.addSubview($0) }
//  }
//  
//  private func setupSNP() {
//    
//    searchTF.snp.makeConstraints {
//      $0.top.equalToSuperview().offset(40)
//      $0.leading.equalToSuperview().offset(40)
//      $0.height.equalTo(50)
//    }
//    
//    searchBtn.snp.makeConstraints {
//      $0.top.equalToSuperview().offset(40)
//      $0.leading.equalTo(searchTF.snp.trailing).offset(20)
//      $0.trailing.equalToSuperview().offset(30)
//      $0.width.height.equalTo(40)
//    }
//    
//    tipLabel.snp.makeConstraints {
//      $0.top.equalTo(searchTF.snp.bottom).offset(20)
//      $0.centerX.centerY.equalToSuperview()
//    }
//    
//    streetLabel.snp.makeConstraints {
//      $0.top.equalTo(tipLabel.snp.bottom).offset(10)
//      $0.centerY.centerX.equalToSuperview()
//    }
//    
//    
//  }
//  
//  private func setupNavigation() {
//    navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
//    navigationController?.navigationBar.shadowImage = UIImage()
//    navigationController?.navigationBar.isTranslucent = true
//    navigationController?.navigationBar.tintColor = .appColor(.appLayerBorderColor)
//  }
//
// 
//
//}
