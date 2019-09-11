//
//  SettingListCell.swift
//  FirstCitizen
//
//  Created by Lee on 11/09/2019.
//  Copyright © 2019 Kira. All rights reserved.
//

import UIKit

protocol SettingListCellDelegate: class {
  func addDidTap(type: ListType)
  func noneDidTap(type: ListType)
}

class SettingListCell: UITableViewCell {
  
  weak var delegate: SettingListCellDelegate?
  
  static let identifier = "SettingListCell"
  
  private var list = [String]()
  private let listCollectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.itemSize = CGSize(width: Standard.itemSize, height: Standard.itemSize)
    layout.scrollDirection = .horizontal
    layout.minimumLineSpacing = 8
    let tempCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    tempCollectionView.contentInset = .zero
    tempCollectionView.contentInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    return tempCollectionView
  }()
  
  private var type: ListType?
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    configure()
    autoLayout()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func setting(type: ListType, list: [String]) {
    self.type = type
    
    self.list = list
    listCollectionView.reloadData()
  }
  
  private func configure() {
    self.selectionStyle = .none
    
    listCollectionView.backgroundColor = .white
    listCollectionView.showsHorizontalScrollIndicator = false
    listCollectionView.dataSource = self
    listCollectionView.delegate = self
    listCollectionView.register(SettingItemCell.self, forCellWithReuseIdentifier: SettingItemCell.identifier)
    listCollectionView.register(SettingItemAddCell.self, forCellWithReuseIdentifier: SettingItemAddCell.identifier)
    contentView.addSubview(listCollectionView)
  }
  
  private struct Standard {
    static let space: CGFloat = 8
    static let itemSize: CGFloat = 72
    static let collectioViewheight: CGFloat = 88
  }
  
  private func autoLayout() {
    listCollectionView.translatesAutoresizingMaskIntoConstraints = false
    listCollectionView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
    listCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
    listCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
    listCollectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    listCollectionView.heightAnchor.constraint(equalToConstant: Standard.collectioViewheight).isActive = true
  }
}

extension SettingListCell: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return list.count + 1
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    switch indexPath.row {
    case list.count:
      guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SettingItemAddCell.identifier, for: indexPath) as? SettingItemAddCell else { fatalError() }
      
      return cell
      
    default:
      guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SettingItemCell.identifier, for: indexPath) as? SettingItemCell else { fatalError() }
      
      cell.setting(item: list[indexPath.row])
      
      return cell
    }
  }
}

extension SettingListCell: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    guard let type = self.type else { return }
    
    switch indexPath.section {
    case list.count:
      delegate?.addDidTap(type: type)
      
    default:
      delegate?.noneDidTap(type: type)
    }
  }
}
