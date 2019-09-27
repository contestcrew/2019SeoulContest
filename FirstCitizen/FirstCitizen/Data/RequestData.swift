//
//  RequestData.swift
//  FirstCitizen
//
//  Created by hyeoktae kwon on 2019/09/28.
//  Copyright © 2019 Kira. All rights reserved.
//

import Foundation

//{
//  "category": 1,
//  "police_office": null,
//  "title": "test",
//  "content": "test",
//  "score": 0,
//  "main_address": "test",
//  "detail_address": "test",
//  "latitude": 37.54334079986058,
//  "longitude": 127.0676820126931,
//  "occurred_at": "2019-09-27 16:23:44"
//}

struct RequestData {
  let category: Int
  let police: Int
  let title: String
  let content: String
  let score: Int
  let mainAdd: String
  let detailAdd: String
  let lat: Double
  let lng: Double
  let time: String
}
