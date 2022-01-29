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
    
    var baseURL: URL {
        return URL(string: APIConstants.baseURL)!
    }
    var path: String {
        "/planetary/apod"
    }
    var method: HttpMethod = .get
    var queryItems: [URLQueryItem] = []
    
    init(date: Date, sDate: Date? = nil, eDate: Date? = nil) {
        self.date = date
        self.startDate = sDate
        self.endDate = eDate
        
        queryItems.append(URLQueryItem(name: "date", value: date.getFormattedDate()))
        
        if let date = self.startDate {
            queryItems.append(URLQueryItem(name: "start_date",
                                           value: date.getFormattedDate()))
        }
        if let date = self.endDate {
            queryItems.append(URLQueryItem(name: "end_date",
                                           value: date.getFormattedDate()))
        }
    }
}

extension Date {
    func getFormattedDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: self)
    }
}
