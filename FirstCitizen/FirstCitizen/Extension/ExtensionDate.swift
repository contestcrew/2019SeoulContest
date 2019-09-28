//
//  ExtensionDate.swift
//  FirstCitizen
//
//  Created by Fury on 28/09/2019.
//  Copyright © 2019 Kira. All rights reserved.
//

import UIKit

extension Date {
  func getToday() -> String {
    let date = Date()
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    dateFormatter.locale = Locale(identifier: "ko_KR")
    
    let result = dateFormatter.string(from: date)
    
    return result
  }
  
  func displayDate(startDate: Date, endDate: Date) {
    do {
      let formatter = DateComponentsFormatter()
      formatter.allowedUnits = [.day]
      formatter.unitsStyle = .full   // 이유는 모르겠으나 꼭 필요하다!
      
      if let daysString = formatter.string(from: startDate, to: endDate) {
        print("\(daysString)만큼 차이납니다.")
      }
    }
  }
}
