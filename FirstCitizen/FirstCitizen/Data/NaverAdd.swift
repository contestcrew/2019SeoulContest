//
//  NaverAdd.swift
//  FirstCitizen
//
//  Created by hyeoktae kwon on 2019/09/30.
//  Copyright © 2019 Kira. All rights reserved.
//

import Foundation

// MARK: - NaverAdd
struct NaverAdd: Codable {
    let status: String
    let meta: Meta
    let places: [Place]
    let errorMessage: String
}

// MARK: - Meta
struct Meta: Codable {
    let totalCount, count: Int
}

// MARK: - Place
struct Place: Codable {
    let name, roadAddress, jibunAddress, phoneNumber: String
    let x, y: String
    let distance: Double
    let sessionID: String

    enum CodingKeys: String, CodingKey {
        case name
        case roadAddress = "road_address"
        case jibunAddress = "jibun_address"
        case phoneNumber = "phone_number"
        case x, y, distance
        case sessionID = "sessionId"
    }
}
