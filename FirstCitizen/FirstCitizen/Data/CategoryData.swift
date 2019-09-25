//
//  CategoryData.swift
//  FirstCitizen
//
//  Created by Fury on 24/09/2019.
//  Copyright © 2019 Kira. All rights reserved.
//

import Foundation

struct CategoryData: Codable {
  let id: Int
  let name: String
  let score: Int
  let image: String
  let pinImage: String
  
  enum CodingKeys: String, CodingKey {
    case id, name, score, image
    case pinImage = "pin_image"
  }
}
