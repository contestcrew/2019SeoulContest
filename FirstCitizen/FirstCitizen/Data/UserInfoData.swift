//
//  UserInfoData.swift
//  FirstCitizen
//
//  Created by Fury on 29/09/2019.
//  Copyright © 2019 Kira. All rights reserved.
//

import Foundation

struct UserInfoData: Decodable {
  let id: Int
  let username, password: String
  let nickname: String?
  let firstName, lastName, email: String
  let phone: Int?
  let grade: Int
  let gender: Int?
  let mannerScore, citizenScore, requestCount: Int
  
  enum CodingKeys: String, CodingKey {
    case id, username, password, nickname
    case firstName = "first_name"
    case lastName = "last_name"
    case email, phone, grade, gender
    case mannerScore = "manner_score"
    case citizenScore = "citizen_score"
    case requestCount = "request_count"
  }
}
