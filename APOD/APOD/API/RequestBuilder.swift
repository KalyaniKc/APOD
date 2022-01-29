//
//  RequestBuilder.swift
//  APOD
//
//  Created by Kalyani Chinchane on 28/01/22.
//

import Foundation
enum HttpMethod: String {
    case get
    case post
}

struct APIConstants {
    static let baseURL = "https://api.nasa.gov"
    fileprivate static let privateKey = "QrD9j9qHdLx89rdLiLyTrr06uFG7mh99zU7DfMV4"
}

private struct ApiAuthConfig {
    // MARK: Public Scope
    static func urlQueryitems() -> [URLQueryItem] {
        return [
            URLQueryItem(name: "api_key", value: APIConstants.privateKey)
        ]
    }
}
protocol RequestBuilder {
    var baseURL: URL { get }
    var path: String { get }
    var method: HttpMethod { get }
    var queryItems: [URLQueryItem] { get set }
    func build() -> URLRequest?
}

extension RequestBuilder {
    var endpoint: URL? {
        let url = baseURL.appendingPathComponent(path)
        var components = URLComponents(url: url,
                                       resolvingAgainstBaseURL: false)
        components?.queryItems = queryItems
        return components?.url
    }

    func build() -> URLRequest? {
        guard let url = endpoint else {
            return nil
        }
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        return request
    }
    
    func enrichAuthConfig() -> RequestBuilder {
        var builder = self
        builder.queryItems.append(contentsOf: ApiAuthConfig.urlQueryitems())
        return builder
    }
}
