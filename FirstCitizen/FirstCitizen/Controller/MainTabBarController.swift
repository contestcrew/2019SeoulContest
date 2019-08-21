//
//  MainTabBarController.swift
//  FirstCitizen
//
//  Created by Lee on 20/08/2019.
//  Copyright © 2019 Kira. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {
  
  let vTabBarButton = TabBarButtonView()
  
  private let vcPoint = PointViewController()
  private let vcMap = MapViewController()
  private let vcList = ListViewController()
  private let vcSetting = SettingViewController()
  
  private var isPosition = true
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    
    configure()
    autoLayout()
  }
  
  private func configure() {
    self.tabBar.isHidden = true
    
    vTabBarButton.pointButton.addTarget(self, action: #selector(pointDidTap(_:)), for: .touchUpInside)
    vTabBarButton.mapListButton.addTarget(self, action: #selector(mapListDidTap(_:)), for: .touchUpInside)
    vTabBarButton.settingButton.addTarget(self, action: #selector(settingDidTap(_:)), for: .touchUpInside)
    view.addSubview(vTabBarButton)
    
    viewControllers = [vcMap, vcList, vcPoint, vcSetting]
    
    
  }
  
  @objc private func pointDidTap(_ sender: UIButton) {
    self.selectedViewController = vcPoint
  }
  
  @objc private func mapListDidTap(_ sender: UIButton) {
    isPosition.toggle()
    
    switch isPosition {
    case true:
      vTabBarButton.mapListButton.setImage(UIImage(named: "MainTabBar_Center_List"), for: .normal)
      self.selectedViewController = vcMap
      
    case false:
      vTabBarButton.mapListButton.setImage(UIImage(named: "MainTabBar_Center_Map"), for: .normal)
      self.selectedViewController = vcList
    }
  }
  
  @objc private func settingDidTap(_ sender: UIButton) {
    self.selectedViewController = vcSetting
  }
  
  private struct Standard {
    static let space: CGFloat = 8
    
  }
  
  private func autoLayout() {
    let guide = view.safeAreaLayoutGuide
    
    vTabBarButton.translatesAutoresizingMaskIntoConstraints = false
    vTabBarButton.leadingAnchor.constraint(equalTo: guide.leadingAnchor).isActive = true
    vTabBarButton.trailingAnchor.constraint(equalTo: guide.trailingAnchor).isActive = true
    vTabBarButton.bottomAnchor.constraint(equalTo: guide.bottomAnchor).isActive = true
  }
}
