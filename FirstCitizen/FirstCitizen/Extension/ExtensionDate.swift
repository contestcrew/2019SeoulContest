//
//  ExtensionDate.swift
//  FirstCitizen
//
//  Created by Fury on 28/09/2019.
//  Copyright © 2019 Kira. All rights reserved.
//

import UIKit

extension Date {
  func daysBetweenDate(toDate: Date) -> Int {
    let components = Calendar.current.dateComponents([.day], from: self, to: toDate)
    return components.day ?? 0
  }
  
  func convertDateFormatter(date: String) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"//this your string date format
    dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?
    dateFormatter.locale = Locale(identifier: "ko_KR")
    let convertedDate = dateFormatter.date(from: date)
    
    guard dateFormatter.date(from: date) != nil else {
      assert(false, "no date from string")
      return ""
    }
    
    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"///this is what you want to convert format
    dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?
    let timeStamp = dateFormatter.string(from: convertedDate!)
    
    return timeStamp
  }
}
