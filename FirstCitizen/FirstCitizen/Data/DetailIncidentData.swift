//
//  DetailIncidentData.swift
//  FirstCitizen
//
//  Created by Fury on 17/09/2019.
//  Copyright © 2019 Kira. All rights reserved.
//

import Foundation

struct DetailIncidentData: Codable {
  let category: String
  let id: Int
  let coordinate: [Float]
  let mainAddress: String
  let detailAddress: String
  let uploadTime: String
  let servicePoint: Int
  let userPoint: Int
  let title: String
  let contents: String
  let occurredTime: String
  let contentImage: String
  
  enum CodingKeys: String, CodingKey {
    case category
    case id
    case coordinate
    case mainAddress = "main_address"
    case detailAddress = "detail_address"
    case uploadTime = "upload_time"
    case servicePoint = "service_point"
    case userPoint = "user_point"
    case title
    case contents
    case occurredTime = "occurred_time"
    case contentImage = "content_image"
  }
}
