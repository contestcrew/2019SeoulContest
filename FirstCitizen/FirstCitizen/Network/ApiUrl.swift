//
//  ApiUrl.swift
//  FirstCitizen
//
//  Created by Fury on 16/09/2019.
//  Copyright © 2019 Kira. All rights reserved.
//

import Foundation

private let baseURL = "http://eb-seoulcontest-deploy-master.ap-northeast-2.elasticbeanstalk.com"

enum FirstCitizenApi {
  case userInfoApi
  case categoryApi
  case homeIncidentApi
  case incidentRequestApi
  case incidentReportApi
  case requestCreate
}

class ApiUrl {
  static func ApiUrl(apiName: FirstCitizenApi) -> String {
    switch apiName {
    case .userInfoApi:
      let userInfoURL: String = "\(baseURL)/account/"
      return userInfoURL
    case .categoryApi:
      let categoryURL: String = "\(baseURL)/request/category/"
      return categoryURL
    case .homeIncidentApi:
      let homeIncidentURL: String = "\(baseURL)/request/boundary/"
      return homeIncidentURL
    case .incidentRequestApi:
      let incidentRequestURL: String = "\(baseURL)/request/"
      return incidentRequestURL
    case .incidentReportApi:
      let incidentReportURL: String = "\(baseURL)/report/"
      return incidentReportURL
    case .requestCreate:
      let url: String = "\(baseURL)/request/"
      return url
    }
  }
}
