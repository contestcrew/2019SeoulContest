//
//  ExtensionDate.swift
//  FirstCitizen
//
//  Created by Fury on 28/09/2019.
//  Copyright © 2019 Kira. All rights reserved.
//

import UIKit

extension Date {
  func daysBetweenDate(toDate: Date) -> String {
    let components = Calendar.current.dateComponents([.second], from: self, to: toDate)
    let absSecond = abs(components.second ?? 0)
    
    if absSecond < 360 {
      return "방금 전"
    } else if absSecond < 3600 {
      return "\(absSecond / 60)분 전"
    } else if absSecond < 86400 {
      return "\(absSecond / 3600)시간 전"
    } else {
      return "\(absSecond / 86400)일 전"
    }
  }
  
  func convertDateFormatter(date: String) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"//this your string date format
    dateFormatter.locale = Locale(identifier: "ko_KR")
    let convertedDate = dateFormatter.date(from: date)
    
    guard dateFormatter.date(from: date) != nil else {
      assert(false, "no date from string")
      return ""
    }
    
    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"///this is what you want to convert format
    let timeStamp = dateFormatter.string(from: convertedDate!)
    
    return timeStamp
  }
  
  func convertOccurredDateFormatter(date: String) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"//this your string date format
    dateFormatter.locale = Locale(identifier: "ko_KR")
    let convertedDate = dateFormatter.date(from: date)
    
    guard dateFormatter.date(from: date) != nil else {
      assert(false, "no date from string")
      return ""
    }
    
    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"///this is what you want to convert format
    let timeStamp = dateFormatter.string(from: convertedDate!)
    
    return timeStamp
  }
}
