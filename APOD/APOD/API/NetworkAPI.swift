//
//  NetworkAPI.swift
//  APOD
//
//  Created by Kalyani Chinchane on 28/01/22.
//

import Foundation
import Combine

protocol NetworkAPIProtocol {
    func perform(_ builder: RequestBuilder) -> AnyPublisher<Data, Error>
}

final class NetworkAPI: NetworkAPIProtocol {
    // MARK: Private Scope
    private init() {}
    private let session = URLSession.shared

    // MARK: Public Scope
    static let shared = NetworkAPI()

    func perform(_ builder: RequestBuilder) -> AnyPublisher<Data, Error> {
        guard let request = builder.enrichAuthConfig().build() else {
            return Fail(error: APIError.invalidURL)
                .eraseToAnyPublisher()
        }
        
        return session.dataTaskPublisher(for: request)
            .tryMap { data, response -> Data in
                guard let httpResponse = response as? HTTPURLResponse,
                      (200 ... 299).contains(httpResponse.statusCode) else {
                          throw APIError.network(string: "Response Error")
                      }
                return data
            }
            .eraseToAnyPublisher()
    }
}
