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
    private lazy var session: URLSession = {
        let configuration = URLSessionConfiguration.default
        configuration.requestCachePolicy = .returnCacheDataElseLoad
        return URLSession(configuration: configuration)
    }()

    var lastSuccessfulResult: CachedURLResponse?
    
    // MARK: Public Scope
    static let shared = NetworkAPI()

    func perform(_ builder: RequestBuilder) -> AnyPublisher<Data, Error> {
        guard let request = builder.enrichAuthConfig().build() else {
            return Fail(error: APIError.invalidURL)
                .eraseToAnyPublisher()
        }
        return session.dataTaskPublisher(for: request).tryMap() { data, response -> Data in
            print(response)
            guard let httpResponse = response as? HTTPURLResponse,
                  httpResponse.statusCode == 200 else {
                      if let lastSuccData = self.lastSuccessfulResult?.data {
                          return lastSuccData
                      } else {
                          throw APIError.network(string: "Response Error")
                      }
                  }
            self.lastSuccessfulResult = CachedURLResponse(response: response, data: data)
            return data
        }.mapError { error -> Error in
            print(error)
            return APIError.network(string: "Response Error")
        }.eraseToAnyPublisher()
    }
}
