//
//  IncidentDataManager.swift
//  FirstCitizen
//
//  Created by Fury on 24/09/2019.
//  Copyright © 2019 Kira. All rights reserved.
//

import Foundation

class IncidentDataManager {
  static let shared = IncidentDataManager()
  
  private init() {}
  
  var incidentDatas: [IncidentData]?
}
