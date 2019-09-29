//
//  UserInfoManager.swift
//  FirstCitizen
//
//  Created by Fury on 30/09/2019.
//  Copyright © 2019 Kira. All rights reserved.
//

import Foundation

class UserInfoManager {
  static let shared = UserInfoManager()
  
  private init() {}
  
  var userInfo: UserInfoData?
}
