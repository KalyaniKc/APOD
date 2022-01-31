//
//  APODResponse.swift
//  APOD
//
//  Created by Kalyani Chinchane on 31/01/22.
//

import Foundation

enum APODMediaType: String, Decodable {
    case image
    case video
}
struct APODJsonResponse : Decodable {
    let copyright: String?
    let date: String
    let explanation: String
    let hdurl: String?
    let media_type: APODMediaType
    let title: String
    let url: String
}

struct APODError: Error, Codable {
    let code: Int
    let msg: String
}
