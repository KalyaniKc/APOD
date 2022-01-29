//
//  APIError.swift
//  APOD
//
//  Created by Kalyani Chinchane on 28/01/22.
//

import Foundation

enum APIError: Error {
    case invalidURL
    case network(string: String)
    case parser(string: String)
    case custom(string: String)
}

extension APIError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .network(string: let message):
            return "Connection: \(message)"
        case .parser(string: let message):
            return "Parser: \(message)"
        case .custom(string: let message):
            return message
        case .invalidURL:
            return "Invalid URL"
        }
    }
}
