//
//  CategoryDataManager.swift
//  FirstCitizen
//
//  Created by Fury on 25/09/2019.
//  Copyright © 2019 Kira. All rights reserved.
//

import Foundation

class CategoryDataManager {
  static let shared = CategoryDataManager()
  
  private init() {}
  
  var categoryData: [CategoryData] = []
}
