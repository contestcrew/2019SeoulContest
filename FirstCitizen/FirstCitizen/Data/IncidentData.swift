//
//  HomeIncidentData.swift
//  FirstCitizen
//
//  Created by Fury on 16/09/2019.
//  Copyright © 2019 Kira. All rights reserved.
//

import Foundation

struct IncidentData: Codable {
  let id, category: Int
  let policeOffice: Int?
  let author: Author
  let title, content, status: String
  let categoryScore, score: Int
  let mainAddress, detailAddress: String?
  let latitude, longitude: Double?
  let occurredAt: String?
  let createdAt: String?
  let updatedAt: String?
  let images: [String]
  
  enum CodingKeys: String, CodingKey {
    case id, category
    case policeOffice = "police_office"
    case author
    case title, content, status
    case categoryScore = "category_score"
    case score
    case mainAddress = "main_address"
    case detailAddress = "detail_address"
    case latitude, longitude
    case occurredAt = "occurred_at"
    case createdAt = "created_at"
    case updatedAt = "updated_at"
    case images
  }
}

struct Author: Codable {
  let id: Int
  let nickname: String
}
