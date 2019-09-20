//
//  TestData.swift
//  FirstCitizen
//
//  Created by hyeoktae kwon on 2019/09/19.
//  Copyright © 2019 Kira. All rights reserved.
//

import Foundation

let sampleDatas = [sampleJsonData1, sampleJsonData2, sampleJsonData3, sampleJsonData4, sampleJsonData5, sampleJsonData6, sampleJsonData7]

let sampleJsonData1 = """
{
"category": "Restroom",
"id": 1,
"coordinate": [36.1234, 127.1234],
"upload_time": "2019-05-06 목요일",
"service_point": 100,
"user_point": 150,
"title": "화장실",
"contents": "어디 화장실인데 화장실 휴지가 너무 필요해요!! 빨리 부탁드려요!!",
"processing": "도움요청중"
}
""".data(using: .utf8)!

let sampleJsonData2 = """
{
"category": "Missing",
"id": 2,
"coordinate": [36.1244, 127.1234],
"upload_time": "2019-05-06 목요일",
"service_point": 100,
"user_point": 250,
"title": "멍멍이 찾아주세요",
"contents": "우리집 여름이가 가출했어요ㅜㅜ 찾아주세요 부탁드림",
"processing": "도움요청중"
}
""".data(using: .utf8)!

let sampleJsonData3 = """
{
"category": "Loss",
"id": 3,
"coordinate": [36.1244, 127.1244],
"upload_time": "2019-05-06 목요일",
"service_point": 100,
"user_point": 350,
"title": "내 에어팟좀요",
"contents": "에어팟 오른쪽 귀좀 찾아주이소!!!",
"processing": "도움요청중"
}
""".data(using: .utf8)!

let sampleJsonData4 = """
{
"category": "Crash",
"id": 4,
"coordinate": [36.1234, 127.1244],
"upload_time": "2019-05-06 목요일",
"service_point": 100,
"user_point": 450,
"title": "목격자 찾음요",
"contents": "여기 사거리에서 나를 박은 씽씽이를 목격한분?",
"processing": "도움요청중"
}
""".data(using: .utf8)!

let sampleJsonData5 = """
{
"category": "Restroom",
"id": 5,
"coordinate": [36.1254, 127.1234],
"upload_time": "2019-05-06 목요일",
"service_point": 100,
"user_point": 550,
"title": "개급함",
"contents": "진심 개급함 똥휴지 급구 진짜 급함 제발요 플리즈 ",
"processing": "도움요청중"
}
""".data(using: .utf8)!

let sampleJsonData6 = """
{
"category": "Restroom",
"id": 1,
"coordinate": [37.5449, 127.0578],
"upload_time": "2019-07-04 목요일",
"service_point": 50,
"user_point": 800,
"title": "화장실",
"contents": "아~~~~~~~~~~~~~~~~~~~~~~죽겠다~~~~~~~~~~~~~~~~~~~~~살려줘~~~~~~~~~~~~~~~~~",
"processing": "도움요청중"
}
""".data(using: .utf8)!

let sampleJsonData7 = """
{
"category": "Crash",
"id": 1,
"coordinate": [37.5430, 127.0500],
"upload_time": "2019-07-04 목요일",
"service_point": 50,
"user_point": 300,
"title": "충돌사고 목격자 찾아요.",
"contents": "인생 ㅅ......",
"processing": "진행중"
}
""".data(using: .utf8)!
