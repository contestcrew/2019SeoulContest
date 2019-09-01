//
//  SignupViewController.swift
//  FirstCitizen
//
//  Created by Fury on 27/08/2019.
//  Copyright © 2019 Kira. All rights reserved.
//

import UIKit
import SnapKit

class SignupViewController: UIViewController {
  
  private let signupView = SignupView()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    layout()
    
    signupView.delegate = self
  }
  
  private func layout() {
    let guide = view.safeAreaLayoutGuide
    
    view.addSubview(signupView)
    signupView.snp.makeConstraints {
      $0.top.equalTo(guide.snp.top)
      $0.leading.equalTo(guide.snp.leading)
      $0.trailing.equalTo(guide.snp.trailing)
      $0.bottom.equalTo(guide.snp.bottom)
    }
  }
}

extension SignupViewController: SignupViewDelegate {
  func touchUpBackButton() {
    self.dismiss(animated: true, completion: nil)
  }
  
  func touchUpSignUpButton() {
    let preparedVC = PreparedViewController()
    self.present(preparedVC, animated: false, completion: nil)
  }
}
