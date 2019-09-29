//
//  ListView.swift
//  FirstCitizen
//
//  Created by Fury on 20/09/2019.
//  Copyright © 2019 Kira. All rights reserved.
//

import UIKit

protocol ListViewDelegate: class {
  func touchUpCategory(categoryIndex: Int)
  func searchIncidents(searchingText: String)
}

class ListView: UIView {
  
  var categoryList: [String] = []
  private var selectedItemIndex: Int = 0
  weak var delegate: ListViewDelegate?
  
  private let searchTextField = UITextField()
  
  private let categoryCollectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .horizontal
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    collectionView.showsHorizontalScrollIndicator = false
    return collectionView
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    attribute()
    layout()
  }
  
  private func attribute() {
    self.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    
    searchTextField.layer.cornerRadius = 10
    searchTextField.layer.borderColor = UIColor.appColor(.appLayerBorderColor).cgColor
    searchTextField.layer.borderWidth = 3
    searchTextField.delegate = self
    searchTextField.rightView = UIImageView(image: #imageLiteral(resourceName: "search"))
    searchTextField.rightView?.frame.inset(by: UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15))
    searchTextField.rightViewMode = .always
    searchTextField.returnKeyType = .done
    
    categoryCollectionView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    categoryCollectionView.dataSource = self
    categoryCollectionView.delegate = self
    categoryCollectionView.register(CategoryCell.self, forCellWithReuseIdentifier: CategoryCell.identifier)
  }
  
  private func layout() {
    let margin: CGFloat = 10
    
    [searchTextField, categoryCollectionView].forEach { self.addSubview($0) }
    
    searchTextField.snp.makeConstraints {
      $0.top.leading.equalToSuperview().offset(margin.dynamic(1))
      $0.trailing.equalToSuperview().offset(-margin.dynamic(1))
      $0.height.equalTo(margin.dynamic(5))
    }
    
    categoryCollectionView.snp.makeConstraints {
      $0.top.equalTo(searchTextField.snp.bottom).offset(margin.dynamic(1))
      $0.leading.trailing.equalToSuperview()
      $0.height.equalTo(margin.dynamic(5))
    }
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension ListView: UITextFieldDelegate {
  func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    
    let updatedText: String = "\(textField.text!)\(string)"
    
    if updatedText.count < 20 {
      delegate?.searchIncidents(searchingText: updatedText)
      return true
    } else {
      return false
    }
  }
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    return true
  }
}

extension ListView: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return categoryList.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCell.identifier, for: indexPath) as! CategoryCell
    cell.cellConfigure(categoryList[indexPath.row])
    
    if indexPath.row == selectedItemIndex {
      cell.categoryName.dynamicFont(fontSize: 26, weight: .bold)
    } else {
      cell.categoryName.dynamicFont(fontSize: 22, weight: .medium)
    }
    
    return cell
  }
}

extension ListView: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let height: CGFloat = 50
    
    // categoryNmae Label의 font 속성을 참조하여 width 설정
    let fontWidthSize: CGFloat = (categoryList[indexPath.row] as NSString).size(withAttributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 24) as Any]).width
    let dynamicWidthSize = (fontWidthSize + 30).dynamic(1)
    return CGSize(width: dynamicWidthSize, height: height.dynamic(1))
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    let spacing: CGFloat = 20
    return spacing.dynamic(1)
  }
}

extension ListView: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
    selectedItemIndex = indexPath.row
    delegate?.touchUpCategory(categoryIndex: selectedItemIndex)
    collectionView.reloadData()
  }
}
