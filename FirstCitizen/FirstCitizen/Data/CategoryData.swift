//
//  CategoryData.swift
//  FirstCitizen
//
//  Created by Fury on 24/09/2019.
//  Copyright © 2019 Kira. All rights reserved.
//

import Foundation

struct CategoryData: Decodable {
  let id: Int
  let name: String
  let score: Int
  let image: String
}
