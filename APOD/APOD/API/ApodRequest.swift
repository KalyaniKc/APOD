//
//  ApodRequest.swift
//  APOD
//
//  Created by Kalyani Chinchane on 28/01/22.
//
import Foundation

struct ApodAPI: RequestBuilder {
    let date: Date
    let startDate: Date?
    let endDate: Date?
    init(date: Date, sDate: Date?, eDate: Date?) {
        self.date = date
        self.startDate = sDate
        self.endDate = eDate
        queryItems.append(contentsOf: [
            URLQueryItem(name: "date", value: "\(date)"),
            URLQueryItem(name: "start_date", value: "\(startDate)"),
            URLQueryItem(name: "end_date", value: "\(endDate)")
        ])
    }
    var baseURL: URL {
        return URL(string: APIConstants.baseURL)!
    }
    var path: String {
        "/planetary/apod"
    }
    var method: HttpMethod = .get
    var queryItems: [URLQueryItem] = []
}
