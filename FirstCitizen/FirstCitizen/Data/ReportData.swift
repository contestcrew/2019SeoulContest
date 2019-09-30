//
//  ReportData.swift
//  FirstCitizen
//
//  Created by Fury on 27/09/2019.
//  Copyright © 2019 Kira. All rights reserved.
//

import Foundation

struct ReportData: Codable {
  let id: Int
  let request: Int
  let author: Author
  let title: String
  let content: String
  let isAgreedInform: Bool
  let helpedAt: String
  let createdAt: String?
  let updatedAt: String?
  let images: [String]?
  let isSelected: Bool
  
  enum CodingKeys: String, CodingKey {
    case id
    case request
    case author
    case title
    case content
    case isAgreedInform = "is_agreed_inform"
    case helpedAt = "helped_at"
    case createdAt = "created_at"
    case updatedAt = "updated_at"
    case images
    case isSelected = "is_select"
  }
  
  
}
