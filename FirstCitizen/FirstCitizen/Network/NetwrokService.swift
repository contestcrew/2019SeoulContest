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
  
  static let header: HTTPHeaders = [
    "Content-Type": "application/json",
    "Authorization": "Token 9e3838aef1806fbe4b6d1edd80f28914148559af"
  ]
  
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
    
    Alamofire.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default).responseData { response in
      
      switch response.result {
      case .success(let data):
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .millisecondsSince1970
        guard let result = try? decoder.decode([IncidentData].self, from: data) else {
          completion(.failure(ErrorType.NoData))
          return
        }
        
        let test = result[0].createdAt ?? ""
        print("[Log4] :", test)
        let date = Date()
        let date2 = date.convertDateFormatter(date: test)
        print("[Log4] :", date2)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        let date3 = dateFormatter.date(from: date2)
        
        
        
        let numOfDays =
        
        completion(.success(result))
      case .failure(_):
        print(ErrorType.networkErr)
      }
    }
  }
  
  
  static func getSettingRequestData(completion: @escaping (Result<[IncidentData]>) -> ()) {
    
    
    //    guard let token = UserDefaults.standard.value(forKey: "Token") else { return }
    //    print("[Log8] :", token)
    
    let headers: HTTPHeaders = [
      "Content-Type": "application/json",
      "Authorization": "Token 9e3838aef1806fbe4b6d1edd80f28914148559af"
    ]
    
    let urlStr = ApiUrl.ApiUrl(apiName: .incidentRequestApi)
    let url: URL = URL(string: urlStr)!
    
    let req = Alamofire.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: headers)
    
    req.validate()
      .responseData { response in
        switch response.result {
        case .success(let data):
          let decoder = JSONDecoder()
          decoder.dateDecodingStrategy = .secondsSince1970
          guard let result = try? decoder.decode([IncidentData].self, from: data) else {
            completion(.failure(ErrorType.NoData))
            return
          }
          
          completion(.success(result))
          
        case .failure(_):
          print(ErrorType.networkErr)
        }
    }
  }
  
  static func getRequestHelpData(requestID: Int, completion: @escaping (Result<[ReportData]>) -> ()) {
    
    //    guard let token = UserDefaults.standard.value(forKey: "Token") else { return }
    
    let header: HTTPHeaders = [
      "Content-Type": "application/json",
      "Authorization": "Token 9e3838aef1806fbe4b6d1edd80f28914148559af"
    ]
    
    let parameters: [String: Int] = ["request": requestID]
    
    let urlStr = ApiUrl.ApiUrl(apiName: .incidentReportApi)
    let url: URL = URL(string: urlStr)!
    
    let req = Alamofire.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: header)
    
    req.validate()
      .responseData { response in
        switch response.result {
        case .success(let data):
          let decoder = JSONDecoder()
          decoder.dateDecodingStrategy = .secondsSince1970
          guard let result = try? decoder.decode([ReportData].self, from: data) else {
            completion(.failure(ErrorType.networkErr))
            return
          }
          
          completion(.success(result))
          
        case .failure(_):
          print(ErrorType.networkErr)
        }
    }
  }
  
  static func createRequest(data: RequestData, completion: @escaping (Bool) -> ()) {
    
    var bodyData: Data
    if data.police == 0 {
      bodyData = """
        {
        "category": "\(data.category)",
        "police_office": "",
        "title": "\(data.title)",
        "content": "\(data.content)",
        "score": "\(data.score)",
        "main_address": "\(data.mainAdd)",
        "detail_address": "\(data.detailAdd)",
        "latitude": "\(data.lat)",
        "longitude": "\(data.lng)",
        "occurred_at": "\(data.time)"
        }
        """.data(using: .utf8)!
    } else {
      bodyData = """
        {
        "category": "\(data.category)",
        "police_office": "\(data.police)",
        "title": "\(data.title)",
        "content": "\(data.content)",
        "score": "\(data.score)",
        "main_address": "\(data.mainAdd)",
        "detail_address": "\(data.detailAdd)",
        "latitude": "\(data.lat)",
        "longitude": "\(data.lng)",
        "occurred_at": "\(data.time)"
        }
        """.data(using: .utf8)!
    }
    
    Alamofire.upload(bodyData,
                     to: ApiUrl.ApiUrl(apiName: .requestCreate),
                     method: .post,
                     headers: header)
      .response { (res) in
        switch res.response?.statusCode {
        case 201:
          completion(true)
        default:
          completion(false)
        }
    }
    
  }
}
