//
//  NetworkService.swift
//  FirstCitizen
//
//  Created by Fury on 24/09/2019.
//  Copyright © 2019 Kira. All rights reserved.
//

import Foundation
import Alamofire

class NetworkService {
  enum ErrorType: Error {
    case networkErr, NoData
  }
  
  static func getCategoryList(completion: @escaping (Result<[CategoryData]>) -> ()) {
    
    let urlStr = ApiUrl.ApiUrl(apiName: .categoryApi)
    let url = URL(string: urlStr)!
    
    Alamofire.request(url).responseData { response in
      switch response.result {
      case .success(let data):
        guard let result = try? JSONDecoder().decode([CategoryData].self, from: data) else {
          completion(.failure(ErrorType.NoData))
          return
        }
        completion(.success(result))
      case .failure(_):
        completion(.failure(ErrorType.networkErr))
      }
    }
  }
  
  static func getHomeIncidentData(latitude: Double, longitude: Double, completion: @escaping (Result<[IncidentData]>) -> ()) {
    
    let parameters: [String: Double] = ["latitude": latitude, "longitude": longitude]
    
    let urlStr = ApiUrl.ApiUrl(apiName: .homeIncidentApi)
    let url = URL(string: urlStr)!
    
    let req = Alamofire.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default)
    
    req.validate()
      .responseData { response in
        switch response.result {
        case .success(let data):
          guard let result = try? JSONDecoder().decode([IncidentData].self, from: data) else {
            completion(.failure(ErrorType.NoData))
            return
          }
          completion(.success(result))
        case .failure(_):
          print(ErrorType.networkErr)
        }
    }
  }
  
  static func getSettingRequestData(completion: @escaping (Result<[DetailIncidentData]>) -> ()) {
    
//    guard let token = UserDefaults.standard.value(forKey: "Token") else { return }
//    print("[Log8] :", token)
    
    let headers: HTTPHeaders = [
      "Content-Type": "application/json",
      "Authorization": "Token bdef7052f9ed4f97bd65ec8afa481bd25deed959"
    ]
    
    let urlStr = ApiUrl.ApiUrl(apiName: .incidentRequestApi)
    let url: URL = URL(string: urlStr)!
    
    let req = Alamofire.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: headers)
    
    req.validate()
      .responseData { response in
        switch response.result {
        case .success(let data):
          guard let result = try? JSONDecoder().decode([DetailIncidentData].self, from: data) else {
            completion(.failure(ErrorType.NoData))
            return
          }
          
          completion(.success(result))
          
        case .failure(_):
          print(ErrorType.networkErr)
        }
    }
  }
  
  static func getRequestHelpData(requestID: Int, completion: @escaping (Result<ReportData>) -> ()) {
    
    guard let token = UserDefaults.standard.value(forKey: "Token") else { return }
    
    let header: HTTPHeaders = [
      "Content-Type": "application/json",
      "Authorization": "Token bdef7052f9ed4f97bd65ec8afa481bd25deed959"
    ]
    
    let parameters: [String: Int] = ["request": requestID]
    
    let urlStr = ApiUrl.ApiUrl(apiName: .incidentReportApi)
    let url: URL = URL(string: urlStr)!
    
    let req = Alamofire.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: header)
    
    req.validate()
      .responseData(queue: DispatchQueue.global()) { response in
        switch response.result {
        case .success(let data):
          guard let result = try? JSONDecoder().decode(ReportData.self, from: data) else {
            completion(.failure(ErrorType.networkErr))
            return
          }
          
          completion(.success(result))
          
        case .failure(_):
          print(ErrorType.networkErr)
        }
    }
  }
}
