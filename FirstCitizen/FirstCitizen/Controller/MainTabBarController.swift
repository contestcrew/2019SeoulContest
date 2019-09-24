//
//  MainTabBarController.swift
//  FirstCitizen
//
//  Created by Lee on 20/08/2019.
//  Copyright © 2019 Kira. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {
  
  static let vTabBarButton = TabBarButtonView()
  
  private let vcPoint = PointViewController()
  private let vcMap = MapViewController()
  private let vcList = ListViewController()
  private let vcSetting = UINavigationController(rootViewController: SettingViewController())
  
  private var isPosition = true
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    
    configure()
    autoLayout()
  }
  
  private func configure() {
    self.tabBar.isHidden = true
    
    MainTabBarController.vTabBarButton.pointButton.addTarget(self, action: #selector(pointDidTap(_:)), for: .touchUpInside)
    MainTabBarController.vTabBarButton.mapListButton.addTarget(self, action: #selector(mapListDidTap(_:)), for: .touchUpInside)
    MainTabBarController.vTabBarButton.settingButton.addTarget(self, action: #selector(settingDidTap(_:)), for: .touchUpInside)
    view.addSubview(MainTabBarController.vTabBarButton)
    
    viewControllers = [vcMap, vcList, vcPoint, vcSetting]
    
    
  }
  
  @objc private func pointDidTap(_ sender: UIButton) {
    self.selectedViewController = vcPoint
  }
  
  @objc private func mapListDidTap(_ sender: UIButton) {
    isPosition.toggle()
    
    switch isPosition {
    case true:
      MainTabBarController.vTabBarButton.mapListButton.setImage(UIImage(named: "TabBarList"), for: .normal)
      self.selectedViewController = vcMap
      
    case false:
      MainTabBarController.vTabBarButton.mapListButton.setImage(UIImage(named: "TabBarMap"), for: .normal)
      self.selectedViewController = vcList
    }
  }
  
  @objc private func settingDidTap(_ sender: UIButton) {
    self.selectedViewController = vcSetting
  }
  
  private struct Standard {
    static let space: CGFloat = 8
    static let margin: CGFloat = 10
  }
  
  private func autoLayout() {
    let guide = view.safeAreaLayoutGuide
    
    MainTabBarController.vTabBarButton.snp.makeConstraints {
      $0.leading.trailing.equalToSuperview()
      $0.bottom.equalTo(guide.snp.bottom).offset(-Standard.margin.dynamic(1))
    }
  }
}
