//
//  HomeIncidentData.swift
//  FirstCitizen
//
//  Created by Fury on 16/09/2019.
//  Copyright © 2019 Kira. All rights reserved.
//

import Foundation

struct HomeIncidentData: Codable {
  let category: String
  let id: Int
  let coordinate: [Float]
  let uploadTime: String
  let servicePoint: Int
  let userPoint: Int
  let title: String
  let contents: String
  
  enum CodingKeys: String, CodingKey {
    case category
    case id
    case coordinate
    case uploadTime = "upload_time"
    case servicePoint = "service_point"
    case userPoint = "user_point"
    case title
    case contents
  }
}
