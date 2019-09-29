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
  
  static func nowTime() -> String {
    let timeFormatter = DateFormatter()
    timeFormatter.locale = Locale(identifier: "ko")
    timeFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    return timeFormatter.string(from: Date())
  }
  
  static let header: HTTPHeaders = [
    "Content-Type": "application/json",
    "Authorization": "Token 9e3838aef1806fbe4b6d1edd80f28914148559af",
  ]
  
  static func getUserInfo(completion: @escaping (Result<UserInfoData>) -> ()) {
    guard let userID = UserDefaults.standard.value(forKey: "userID") else { return }
    
    let urlStr = ApiUrl.ApiUrl(apiName: .userInfoApi)
    let fullUrlStr = "\(urlStr)\(userID)"
    let url: URL = URL(string: fullUrlStr)!
    
    let req = Alamofire.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil)
    
    req.validate()
      .responseData { response in
        switch response.result {
        case .success(let data):
          guard let result = try? JSONDecoder().decode(UserInfoData.self, from: data) else {
            completion(.failure(ErrorType.NoData))
            return
          }
          completion(.success(result))
        case .failure(_):
          completion(.failure(ErrorType.networkErr))
        }
    }
  }
  
  static func restroomReport(requestID: Int, completion: @escaping (Bool) -> ()) {
    
    guard let token = UserDefaults.standard.string(forKey: "Token") else { return }
    print("[Toekn] restroom :", token)
    let urlStr = ApiUrl.ApiUrl(apiName: .incidentReportApi)
    let url: URL = URL(string: urlStr)!
    
    let headers: HTTPHeaders = [
      "Content-Type": "application/json",
      "Authorization": "\(token)"
    ]
    
    let body = """
      {
      "request": "\(requestID)",
      "title": "",
      "content": "",
      "is_agreed_inform": "false",
      "helped_at": "\(nowTime())",
      }
      """.data(using: .utf8)
    
    guard let data = body else { return }
    
    Alamofire.upload(data, to: url, method: .post, headers: headers)
      .responseData(queue: .global()) { res in
        switch res.result {
        case .success(_):
          completion(true)
        case .failure(_):
          completion(false)
        }
    }
  }
  
  static func report(data: ReportData, images: [UIImage], completion: @escaping (Bool) -> ()) {
    
    var imgData = [Data]()
    
    images.forEach {
      imgData.append($0.pngData()!)
    }
    
    let url = ApiUrl.ApiUrl(apiName: .incidentReportApi)
    
    let multiData = MultipartFormData()
    multiData.append("1".data(using: .utf8)!, withName: "request")
    multiData.append("\(data.author)".data(using: .utf8)!, withName: "author")
    multiData.append(data.title.data(using: .utf8)!, withName: "title")
    multiData.append(data.content.data(using: .utf8)!, withName: "content")
    multiData.append("\(data.isAgreedInform)".data(using: .utf8)!, withName: "is_agreed_inform")
    multiData.append(nowTime().data(using: .utf8)!, withName: "helped_at")
    if imgData.count != 0 {
      for (data) in imgData {
        multiData.append(data, withName: "images")
      }
    }
    
    let encodeData = try? multiData.encode()
    
    let testHeaders = [
      "content-type": "\(multiData.contentType)",
      "Accept": "*/*",
      "Cache-Control": "no-cache",
      "Host": "eb-seoulcontest-deploy-master.ap-northeast-2.elasticbeanstalk.com",
      "Accept-Encoding": "gzip, deflate",
      "Content-Length": "\(multiData.contentLength)",
      "Connection": "keep-alive",
      "cache-control": "no-cache"
    ]
    
    //    let data = """
    //      {
    //      "request": "1",
    //      "author": "\(data.author)",
    //      "title": "\(data.title)",
    //      "content": "\(data.content)",
    //      "is_agreed_inform": "\(data.isAgreedInform)",
    //      "helped_at": "\(nowTime())",
    //      "images": "\(imgData)"
    //      }
    //      """.data(using: .utf8)!
    
    
    
    //    Alamofire.upload(multipartFormData: { (MultipartFormData) in
    //      MultipartFormData.append("1".data(using: .utf8)!, withName: "request")
    //      MultipartFormData.append("\(data.author)".data(using: .utf8)!, withName: "author")
    //      MultipartFormData.append(data.title.data(using: .utf8)!, withName: "title")
    //      MultipartFormData.append(data.content.data(using: .utf8)!, withName: "content")
    //      MultipartFormData.append("\(data.isAgreedInform)".data(using: .utf8)!, withName: "is_agreed_inform")
    //      MultipartFormData.append(nowTime().data(using: .utf8)!, withName: "helped_at")
    //      if imgData.count != 0 {
    //        for (idx, data) in imgData.enumerated() {
    //          MultipartFormData.append(data, withName: "image_\(idx+1)")
    //        }
    //      }
    //
    //      print("multipartFormData: ", MultipartFormData.contentLength)
    //    }, to: url, method: .post, headers: header) { (result) in
    //      print("result encoding: ", result)
    //      }
    print("encoded Data: ", encodeData!)
    
    let req = try! URLRequest(url: url, method: .post, headers: testHeaders)
    
    Alamofire.upload(encodeData ?? Data(), with: req)
      .response { (res) in
        print("Header: ", res.request?.allHTTPHeaderFields)
        switch res.response?.statusCode {
        case 201:
          completion(true)
          let data = try? JSONSerialization.jsonObject(with: res.data!)
          print("result Data: ", data)
        default:
          completion(false)
          let data = try? JSONSerialization.jsonObject(with: res.data!)
          print("result Data: ", data)
        }
    }
    
    
    //        Alamofire.upload(encodeData ?? Data(),
    //                     to: url,
    //                     method: .post,
    //                     headers: header)
    //      .response { (res) in
    //        switch res.response?.statusCode {
    //        case 201:
    //          completion(true)
    //          let data = try? JSONSerialization.jsonObject(with: res.data!)
    //          print("result Data: ", data)
    //        default:
    //          completion(false)
    //          let data = try? JSONSerialization.jsonObject(with: res.data!)
    //          print("result Data: ", data)
    //        }
    //    }
    
    
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
    
    Alamofire.request(urlStr, method: .get, parameters: parameters, encoding: URLEncoding.default)
      .responseData { response in
        
        switch response.result {
        case .success(let data):
          let decoder = JSONDecoder()
          decoder.dateDecodingStrategy = .millisecondsSince1970
          guard let result = try? decoder.decode([IncidentData].self, from: data) else {
            completion(.failure(ErrorType.NoData))
            return
          }
          
          //        let test = result[0].createdAt ?? ""
          //        print("[Log4] :", test)
          //        let date = Date()
          //        let date2 = date.convertDateFormatter(date: test)
          //        print("[Log4] :", date2)
          //
          //        let dateFormatter = DateFormatter()
          //        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
          //        let date3 = dateFormatter.date(from: date2)
          
          
          
          
          
          completion(.success(result))
        case .failure(_):
          print(ErrorType.networkErr)
        }
    }
  }
  
  
  static func getSettingRequestData(completion: @escaping (Result<[IncidentData]>) -> ()) {
    
    
    guard let token = UserDefaults.standard.value(forKey: "Token") else { return }
    
    let headers: HTTPHeaders = [
      "Content-Type": "application/json",
      "Authorization": "\(token)"
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
    
    guard let token = UserDefaults.standard.value(forKey: "Token") else { return }
    
    let headers: HTTPHeaders = [
      "Content-Type": "application/json",
      "Authorization": "\(token)"
    ]
    
    let parameters: [String: Int] = ["request": requestID]
    
    let urlStr = ApiUrl.ApiUrl(apiName: .incidentReportApi)
    let url: URL = URL(string: urlStr)!
    
    let req = Alamofire.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: headers)
    
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
    
    print("create Request Data: ", data)
    
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
