//
//  PointView.swift
//  FirstCitizen
//
//  Created by Lee on 20/08/2019.
//  Copyright © 2019 Kira. All rights reserved.
//

import UIKit

class PointView: UIView {
  
  private let cardView = UIView()
  private let gradient = CAGradientLayer()
  
  private let titleLabel = UILabel()
  private let subLabel = UILabel()

  override init(frame: CGRect) {
    super.init(frame: frame)
    
    configure()
    autoLayout()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    
    gradient.startPoint = CGPoint(x: 1, y: 0)
    gradient.endPoint = CGPoint(x: 0, y: 1)
    gradient.colors = [
      UIColor(hexString: "001182").cgColor,
      UIColor(hexString: "020626").cgColor
    ]
    gradient.locations = [0, 1]
    gradient.frame = CGRect(origin: .zero, size: cardView.frame.size)
    
    cardView.layer.addSublayer(gradient)
    
  }
  
  private func configure() {
    cardView.layer.cornerRadius = 16
    cardView.layer.masksToBounds = true
    self.addSubview(cardView)
    
    
    titleLabel.text = "업's"
    titleLabel.textColor = .white
    titleLabel.upsFontHeavy(ofSize: 25)
    self.addSubview(titleLabel)
    
    subLabel.text = "kira1021@gmail.com"
    subLabel.textColor = .white
    self.addSubview(subLabel)
    
    
  }
  
  private struct Standard {
    static let space: CGFloat = 8
    
    static let cardSpace: CGFloat = 40
    static let cardHeight: CGFloat = 160
    static let cardContentSpace: CGFloat = 16
  }
  
  private func autoLayout() {
    cardView.translatesAutoresizingMaskIntoConstraints = false
    cardView.topAnchor.constraint(equalTo: self.topAnchor, constant: Standard.cardSpace).isActive = true
    cardView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Standard.cardSpace).isActive = true
    cardView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Standard.cardSpace).isActive = true
    cardView.heightAnchor.constraint(equalToConstant: Standard.cardHeight).isActive = true
    
    titleLabel.translatesAutoresizingMaskIntoConstraints = false
    titleLabel.topAnchor.constraint(equalTo: cardView.topAnchor, constant: Standard.cardContentSpace).isActive = true
    titleLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: Standard.cardContentSpace).isActive = true
    
    subLabel.translatesAutoresizingMaskIntoConstraints = false
    subLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: Standard.cardContentSpace).isActive = true
    subLabel.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -Standard.cardContentSpace).isActive = true
  }
}
