
//
//  RequestDetailView.swift
//  FirstCitizen
//
//  Created by Fury on 23/09/2019.
//  Copyright © 2019 Kira. All rights reserved.
//

import UIKit
import NMapsMap

class RequestDetailView: UIView {
  
  var category: String = ""
  
  private let nmapView = NMFMapView()
  private let gradientView = UIImageView()
  
  private let backButton = UIButton()
  
  private let bodyScrollView = UIScrollView()
  private let bodyView = UIView()
  private let titleLabel = UILabel()
  private let imageView = UIImageView()
  private let titleUnderLineView = UIView()
  private let regionLabel = UILabel()
  private let pointLabel = UILabel()
  private let uploadTimeLabel = UILabel()
  
  private let occurredTimeLabel = UILabel()
  private let occurredTimeUnderLineView = UIView()
  private let occurredTimeText = UILabel()
  
  private let pictureLabel = UILabel()
  private let pictureUnderLineView = UIView()
  
  private let pictureCollectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .horizontal
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    collectionView.showsHorizontalScrollIndicator = false
    collectionView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    return collectionView
  }()
  
  private let messageLabel = UILabel()
  private let messageUnderLineView = UIView()
  private let contentsLabel = UILabel()
  
  private let helpLabel = UILabel()
  private let helpUnderLineView = UIView()
  private let helpListTableView = UITableView()
  
  init(frame: CGRect, category: String) {
    super.init(frame: frame)
    
    self.category = category
    attribute()
    layout()
  }
  
  @objc private func touchUpBackButton() {
//    delegate?.touchUpBackButton()
  }
  
  private func attribute() {
    gradientView.image = UIImage(named: "Gradient")
    gradientView.contentMode = .scaleToFill
    
    backButton.setImage(#imageLiteral(resourceName: "Back_Button"), for: .normal)
    backButton.addTarget(self, action: #selector(touchUpBackButton), for: .touchUpInside)
    
    titleLabel.text = "하늘에서 날개를 잃어버렸어요..."
    titleLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    titleLabel.font = UIFont.systemFont(ofSize: 28, weight: .bold)
    
    imageView.contentMode = .scaleAspectFit
    imageView.image = #imageLiteral(resourceName: "Restroom")
    
    titleUnderLineView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    
    regionLabel.text = "서울특별시 성동구 성수22길 37, 사거리"
    regionLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    regionLabel.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
    regionLabel.numberOfLines = 0
    
    pointLabel.text = "1000"
    pointLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    pointLabel.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
    
    uploadTimeLabel.text = "2019-06-04 목요일"
    uploadTimeLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    uploadTimeLabel.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
    
    occurredTimeLabel.text = "발생시각"
    occurredTimeLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    occurredTimeLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
    
    occurredTimeUnderLineView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    
    occurredTimeText.text = "09:10"
    occurredTimeText.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    occurredTimeText.font = UIFont.systemFont(ofSize: 16, weight: .bold)
    
    pictureLabel.text = "사진"
    pictureLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    pictureLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
    
    pictureUnderLineView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    
    pictureCollectionView.dataSource = self
    pictureCollectionView.delegate = self
    pictureCollectionView.register(IncidentCell.self, forCellWithReuseIdentifier: IncidentCell.identifier)
    
    messageLabel.text = "메세지"
    messageLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    messageLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
    
    messageUnderLineView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    
    contentsLabel.text = "내 날개좀.. 찾아주세요.. 부탁드려요 ㅠㅠㅠㅠ"
    contentsLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    contentsLabel.textAlignment = .justified
    contentsLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
    contentsLabel.numberOfLines = 0
    
    helpLabel.text = "메세지"
    helpLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    helpLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
    
    helpUnderLineView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    
    helpListTableView.dataSource = self
    helpListTableView.register(RequestDetailCell.self, forCellReuseIdentifier: RequestDetailCell.identifier)
  }
  
  private func layout() {
    [bodyScrollView].forEach { self.addSubview($0) }
    
    [nmapView, gradientView, bodyView].forEach { bodyScrollView.addSubview($0) }
    
    if category == "Restroom" {
      [titleLabel, imageView, titleUnderLineView, regionLabel, pointLabel, uploadTimeLabel, messageLabel, messageUnderLineView, contentsLabel, helpLabel, helpUnderLineView, helpListTableView].forEach {
        bodyView.addSubview($0)
      }
    } else {
      [titleLabel, imageView, titleUnderLineView, regionLabel, pointLabel, uploadTimeLabel, occurredTimeLabel, occurredTimeUnderLineView, occurredTimeText, pictureLabel, pictureUnderLineView, pictureCollectionView, messageLabel, messageUnderLineView, contentsLabel, helpLabel, helpUnderLineView, helpListTableView].forEach {
        bodyView.addSubview($0)
      }
    }
    
    self.addSubview(backButton)
    
    backButton.snp.makeConstraints {
      $0.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(10)
      $0.leading.equalTo(self.safeAreaLayoutGuide.snp.leading).offset(10)
      $0.width.height.equalTo(35)
    }
    
    bodyScrollView.snp.makeConstraints {
      $0.top.leading.trailing.equalTo(self)
      $0.bottom.equalTo(helpListTableView.snp.bottom)
    }
    
    nmapView.snp.makeConstraints {
      $0.top.leading.trailing.equalTo(bodyScrollView)
      $0.height.equalTo(self).multipliedBy(0.5)
    }
    
    gradientView.snp.makeConstraints {
      $0.leading.trailing.equalTo(bodyScrollView)
      $0.bottom.equalTo(nmapView.snp.bottom)
      $0.height.equalTo(100)
    }
    
    bodyView.snp.makeConstraints {
      $0.top.equalTo(nmapView.snp.bottom)
      $0.bottom.equalTo(bodyScrollView)
      $0.leading.equalTo(self).offset(20)
      $0.trailing.equalTo(self).offset(-20)
    }
    
    titleLabel.snp.makeConstraints {
      $0.top.leading.trailing.equalTo(bodyView)
    }
    
    imageView.snp.makeConstraints {
      $0.centerY.equalTo(titleLabel.snp.centerY)
      $0.trailing.equalTo(self).offset(-20)
      $0.width.height.equalTo(35)
    }
    
    titleUnderLineView.snp.makeConstraints {
      $0.top.equalTo(titleLabel.snp.bottom).offset(10)
      $0.leading.trailing.equalTo(bodyView)
      $0.height.equalTo(1)
    }
    
    regionLabel.snp.makeConstraints {
      $0.top.equalTo(titleUnderLineView.snp.bottom).offset(10)
      $0.trailing.equalTo(bodyView)
    }
    
    pointLabel.snp.makeConstraints {
      $0.top.equalTo(regionLabel.snp.bottom).offset(10)
      $0.trailing.equalTo(bodyView)
    }
    
    uploadTimeLabel.snp.makeConstraints {
      $0.top.equalTo(pointLabel.snp.bottom).offset(10)
      $0.trailing.equalTo(bodyView)
    }
    
    if category == "Restroom" {
      messageLabel.snp.makeConstraints {
        $0.top.equalTo(uploadTimeLabel.snp.bottom).offset(20)
        $0.leading.equalTo(bodyView)
      }
    } else {
      occurredTimeLabel.snp.makeConstraints {
        $0.top.equalTo(uploadTimeLabel.snp.bottom).offset(20)
        $0.leading.equalTo(bodyView)
      }
      
      occurredTimeUnderLineView.snp.makeConstraints {
        $0.top.equalTo(occurredTimeLabel.snp.bottom).offset(10)
        $0.leading.trailing.equalTo(bodyView)
        $0.height.equalTo(1)
      }
      
      occurredTimeText.snp.makeConstraints {
        $0.top.equalTo(occurredTimeUnderLineView.snp.bottom).offset(10)
        $0.leading.trailing.equalTo(bodyView)
      }
      
      pictureLabel.snp.makeConstraints {
        $0.top.equalTo(occurredTimeText.snp.bottom).offset(20)
        $0.leading.equalTo(bodyView)
      }
      
      pictureUnderLineView.snp.makeConstraints {
        $0.top.equalTo(pictureLabel.snp.bottom).offset(10)
        $0.leading.trailing.equalTo(bodyView)
        $0.height.equalTo(1)
      }
      
      // TODO: 한 곳에서 width, height 처리할 것
      let width = UIScreen.main.bounds.width - 60
      let height = (width * 3) / 4
      
      pictureCollectionView.snp.makeConstraints {
        $0.top.equalTo(pictureUnderLineView.snp.bottom).offset(20)
        $0.leading.equalTo(self)
        $0.trailing.equalTo(self)
        $0.height.equalTo(height)
      }
      
      messageLabel.snp.makeConstraints {
        $0.top.equalTo(pictureCollectionView.snp.bottom).offset(20)
        $0.leading.equalTo(bodyView)
      }
    }
    
    messageUnderLineView.snp.makeConstraints {
      $0.top.equalTo(messageLabel.snp.bottom).offset(10)
      $0.leading.trailing.equalTo(bodyView)
      $0.height.equalTo(1)
    }
    
    contentsLabel.snp.makeConstraints {
      $0.top.equalTo(messageUnderLineView.snp.bottom).offset(10)
      $0.leading.trailing.equalTo(bodyView)
      $0.bottom.equalTo(bodyView).offset(-20)
    }
    
    helpLabel.snp.makeConstraints {
      $0.top.equalTo(contentsLabel.snp.bottom).offset(20)
      $0.leading.equalTo(bodyView)
    }
    
    messageUnderLineView.snp.makeConstraints {
      $0.top.equalTo(helpLabel.snp.bottom).offset(10)
      $0.leading.trailing.equalTo(bodyView)
      $0.height.equalTo(1)
    }
    
    helpListTableView.snp.makeConstraints {
      $0.top.equalTo(messageUnderLineView.snp.bottom).offset(10)
      $0.leading.trailing.equalTo(bodyView)
      $0.bottom.equalTo(bodyView).offset(-20)
    }
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension RequestDetailView: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 5
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: IncidentCell.identifier, for: indexPath) as! IncidentCell
    cell.incidentCellConfigure(reportImage: #imageLiteral(resourceName: "sample_image_2"))
    return cell
  }
}

extension RequestDetailView: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let width = UIScreen.main.bounds.width - 60
    let height = (width * 3) / 4
    return CGSize(width: width, height: height)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 20
  }
}

extension RequestDetailView: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 5
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: RequestDetailCell.identifier, for: indexPath) as! RequestDetailCell
    
    return cell
  }
}
