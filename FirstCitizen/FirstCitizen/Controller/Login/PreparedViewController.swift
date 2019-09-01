//
//  PreparedViewController.swift
//  FirstCitizen
//
//  Created by Fury on 26/08/2019.
//  Copyright © 2019 Kira. All rights reserved.
//

import UIKit
import SnapKit

class PreparedViewController: UIViewController {
  var isSocialLogin: Bool = false
  private let preparedView = PreparedView()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    
    preparedView.delegate = self
    
    addKeyboardNotification()
    layout()
  }
  
  private func addKeyboardNotification() {
    NotificationCenter.default.addObserver(
      self,
      selector: #selector(keyboardWillShow),
      name: UIResponder.keyboardWillShowNotification,
      object: nil
    )
    
    NotificationCenter.default.addObserver(
      self,
      selector: #selector(keyboardWillHide),
      name: UIResponder.keyboardWillHideNotification,
      object: nil
    )
  }
  
  @objc private func keyboardWillShow(_ notification: Notification) {
    if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
      let keybaordRectangle = keyboardFrame.cgRectValue
      let keyboardHeight = keybaordRectangle.height
      preparedView.nextButton.frame.origin.y -= keyboardHeight
    }
  }
  
  @objc private func keyboardWillHide(_ notification: Notification) {
    if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
      let keybaordRectangle = keyboardFrame.cgRectValue
      let keyboardHeight = keybaordRectangle.height
      preparedView.nextButton.frame.origin.y += keyboardHeight
    }
  }
  
  private func layout() {
    self.view.addSubview(preparedView)
    
    preparedView.snp.makeConstraints {
      $0.top.leading.trailing.bottom.equalToSuperview()
    }
  }
}



extension PreparedViewController: PreparedViewDelegate {
  func touchUpBackButton() {
    if isSocialLogin {
      self.dismiss(animated: true, completion: nil)
    } else {
      self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
  }
  
  func touchUpNextButton() {
    let mainTabBarController = MainTabBarController()
    self.present(mainTabBarController, animated: false, completion: nil)
  }
}
