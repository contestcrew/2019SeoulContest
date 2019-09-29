//
//  ReportDataManager.swift
//  FirstCitizen
//
//  Created by Fury on 30/09/2019.
//  Copyright © 2019 Kira. All rights reserved.
//

import Foundation

class ReportDataManager {
  static let shared = ReportDataManager()
  
  private init() {}
  
  var reportCategory: String = ""
  var reportDatas: [ReportData] = []
}
