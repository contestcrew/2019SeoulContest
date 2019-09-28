//
//  IncidentCollectionViewCell.swift
//  FirstCitizen
//
//  Created by Fury on 10/09/2019.
//  Copyright © 2019 Kira. All rights reserved.
//

import UIKit

class IncidentCell: UICollectionViewCell {
  
  static let identifier = "IncidentCell"
  
  private let imageView = UIImageView()
    
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    attribute()
    layout()
  }
  
  func incidentCellConfigure(isNoPicture: Bool, imageStr: String?) {
    if isNoPicture {
      imageView.image = #imageLiteral(resourceName: "no_image_icon")
    } else {
      let imageURL: URL = URL(string: imageStr!)!
      imageView.kf.setImage(with: imageURL)
    }
  }
  
  private func attribute() {
    imageView.contentMode = .scaleAspectFill
    imageView.clipsToBounds = true
  }
  
  private func layout() {
    self.contentView.addSubview(imageView)
    
    imageView.snp.makeConstraints {
      $0.top.leading.trailing.bottom.equalTo(contentView)
    }
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
