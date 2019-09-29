//
//  ExtensionString.swift
//  FirstCitizen
//
//  Created by Fury on 28/09/2019.
//  Copyright © 2019 Kira. All rights reserved.
//

import Foundation

extension String {
  func makeDisplayTime() -> String {
    var result = self.replacingOccurrences(of: "T", with: " ")
    let resultArr = result.split(separator: ".")
    result = String(resultArr[0])
    return result
  }
}
