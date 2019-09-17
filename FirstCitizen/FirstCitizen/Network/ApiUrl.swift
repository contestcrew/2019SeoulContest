//
//  ApiUrl.swift
//  FirstCitizen
//
//  Created by Fury on 16/09/2019.
//  Copyright © 2019 Kira. All rights reserved.
//

import Foundation

enum FirstCitizenApi {
  case homeIncidentApi
}

class ApiUrl {
  static func ApiUrl(apiName: FirstCitizenApi) -> String {
    switch apiName {
    case .homeIncidentApi:
      let homeIncidentURL: String = ""
      return homeIncidentURL
    }
  }
}
