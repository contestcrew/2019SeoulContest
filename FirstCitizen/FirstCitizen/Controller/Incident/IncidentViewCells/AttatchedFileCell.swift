//
//  AttatchedFileCell.swift
//  FirstCitizen
//
//  Created by Fury on 24/09/2019.
//  Copyright © 2019 Kira. All rights reserved.
//

import UIKit

class AttatchedFileCell: UITableViewCell {
  
  static let identifier = "AttatchedFileCell"
  
  private var pictureDatas: [String] = []
  
  private let pictureLabel = UILabel()
  private let pictureUnderLineLabel = UILabel()
  
  private let pictureCollectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .horizontal
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    collectionView.showsHorizontalScrollIndicator = false
    collectionView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    return collectionView
  }()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    attribute()
    layout()
  }
  
  func modifyProperties(imagesStr: [String]) {
    pictureDatas = imagesStr
    pictureCollectionView.reloadData()
  }
  
  private func attribute() {
    pictureLabel.text = "사진"
    pictureLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    pictureLabel.dynamicFont(fontSize: 24, weight: .bold)
    
    pictureUnderLineLabel.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    
    pictureCollectionView.dataSource = self
    pictureCollectionView.delegate = self
    pictureCollectionView.register(IncidentCell.self, forCellWithReuseIdentifier: IncidentCell.identifier)
  }
  
  private func layout() {
    let margin: CGFloat = 10
    
    [pictureLabel, pictureUnderLineLabel, pictureCollectionView].forEach { contentView.addSubview($0) }
    
    contentView.snp.makeConstraints {
      $0.leading.equalTo(self).offset(margin.dynamic(2))
      $0.trailing.equalTo(self).offset(-margin.dynamic(2))
    }
    
    pictureLabel.snp.makeConstraints {
      $0.top.equalTo(contentView).offset(margin.dynamic(2))
      $0.leading.equalTo(contentView)
    }
    
    pictureUnderLineLabel.snp.makeConstraints {
      $0.top.equalTo(pictureLabel.snp.bottom).offset(margin.dynamic(1))
      $0.leading.trailing.equalTo(contentView)
      $0.height.equalTo(margin.dynamic(0.1))
    }
    
    // TODO: 한 곳에서 width, height 처리할 것
    let width = UIScreen.main.bounds.width - 60
    let height = (width * 3) / 4
    
    pictureCollectionView.snp.makeConstraints {
      $0.top.equalTo(pictureUnderLineLabel.snp.bottom).offset(margin.dynamic(2))
      $0.leading.equalTo(self)
      $0.trailing.equalTo(self)
      $0.bottom.equalTo(contentView).offset(-margin.dynamic(1))
      $0.height.equalTo(height)
    }
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension AttatchedFileCell: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    if pictureDatas.count == 0 {
      return 1
    } else {
      return pictureDatas.count
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: IncidentCell.identifier, for: indexPath) as! IncidentCell
    
    if pictureDatas.count == 0 {
      cell.incidentCellConfigure(isNoPicture: true, imageStr: nil)
    } else {
      cell.incidentCellConfigure(isNoPicture: false, imageStr: pictureDatas[indexPath.row])
    }
    return cell
  }
}

extension AttatchedFileCell: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let width = UIScreen.main.bounds.width - 60
    let height = (width * 3) / 4
    return CGSize(width: width, height: height)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    let spacing: CGFloat = 20
    return spacing.dynamic(1)
  }
}
