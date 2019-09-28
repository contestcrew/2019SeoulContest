//
//  ImageCell.swift
//  FirstCitizen
//
//  Created by hyeoktae kwon on 2019/09/29.
//  Copyright © 2019 Kira. All rights reserved.
//

import UIKit
import SnapKit

class ImageCell: UICollectionViewCell {
  let imgView = UIImageView()
  
  override func didMoveToSuperview() {
    self.addSubview(imgView)
    imgView.contentMode = .scaleAspectFit
    imgView.snp.makeConstraints {
      $0.leading.trailing.bottom.top.equalTo(self.contentView)
    }
  }
}
