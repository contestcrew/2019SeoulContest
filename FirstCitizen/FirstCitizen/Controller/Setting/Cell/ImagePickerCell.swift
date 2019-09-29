//
//  ImagePickerCell.swift
//  FirstCitizen
//
//  Created by hyeoktae kwon on 2019/09/30.
//  Copyright © 2019 Kira. All rights reserved.
//

import UIKit
import SnapKit
import TLPhotoPicker

protocol ImagePickerCellDelegate: class {
  func didTapImageAddBtn()
  func tableviewReload()
}

class ImagePickerCell: UITableViewCell {
  
  weak var delegate: ImagePickerCellDelegate?
  
  var imageArr = [UIImage]() {
    didSet {
      collectionView.reloadData()
      delegate?.tableviewReload()
    }
  }
  
  lazy var imageAddBtn: UIButton = {
    let btn = UIButton(type: .system)
    btn.setTitle("이미지 추가하기", for: .normal)
    btn.addTarget(self, action: #selector(didTapSelectImgBtn(_:)), for: .touchUpInside)
    btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
//    btn.titleLabel?.textColor = .black
    return btn
  }()
  
  let flowLayout: UICollectionViewFlowLayout = {
    let layout = UICollectionViewFlowLayout()
    let count = CGFloat(3)
    let width = (UIScreen.main.bounds.width-(5*(count-1)))/count
    layout.scrollDirection = .horizontal
    layout.itemSize = CGSize(width: width, height: width)
    return layout
  }()
  
  lazy var collectionView: UICollectionView = {
    let view = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
    view.backgroundColor = .clear
    view.register(ImageCell.self, forCellWithReuseIdentifier: "cell")
    view.dataSource = self
    view.delegate = self
    return view
  }()
  
  override func didMoveToSuperview() {
    super.didMoveToSuperview()
    
  }
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    print("init")
    collectionView.dataSource = self
    collectionView.delegate = self
    setupSnp()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  @objc func didTapSelectImgBtn(_ sender: UIButton) {
    delegate?.didTapImageAddBtn()
  }
  
  func setupSnp() {
    print("run in setupSnp")
    [imageAddBtn, collectionView].forEach {
      self.contentView.addSubview($0)
    }
    
    imageAddBtn.snp.remakeConstraints {
      $0.leading.top.trailing.equalTo(self.contentView)
      $0.height.equalTo(30)
      //      $0.bottom.equalTo(collectionView.snp.top)
    }
//    if imageArr.count != 0 {
      collectionView.snp.makeConstraints {
        $0.leading.trailing.bottom.equalTo(self.contentView)
        $0.top.equalTo(imageAddBtn.snp.bottom)
        $0.height.equalTo(200)
      }
//    }
  }
  
}

extension ImagePickerCell: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return imageArr.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ImageCell
    let image = imageArr[indexPath.row]
    cell.imgView.image = image
    return cell
  }
  
}

extension ImagePickerCell: UICollectionViewDelegate {
  
}
