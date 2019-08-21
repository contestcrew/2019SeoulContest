//
//  PointViewController.swift
//  FirstCitizen
//
//  Created by Lee on 20/08/2019.
//  Copyright © 2019 Kira. All rights reserved.
//

import UIKit

class PointViewController: UIViewController {
  
  private let vPoint = PointView()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    configure()
    autoLayout()
  }
  
  private func configure() {
    view.backgroundColor = .white
    
    view.addSubview(vPoint)
  }
  
  private struct Standard {
    static let space: CGFloat = 8
    
  }
  
  private func autoLayout() {
    let guide = view.safeAreaLayoutGuide
    
    vPoint.translatesAutoresizingMaskIntoConstraints = false
    vPoint.topAnchor.constraint(equalTo: guide.topAnchor).isActive = true
    vPoint.leadingAnchor.constraint(equalTo: guide.leadingAnchor).isActive = true
    vPoint.trailingAnchor.constraint(equalTo: guide.trailingAnchor).isActive = true
    vPoint.bottomAnchor.constraint(equalTo: guide.bottomAnchor, constant: -TabBarButtonView.height).isActive = true
  }
}
