//
//  AstronomyViewModel.swift
//  APOD
//
//  Created by Kalyani Chinchane on 29/01/22.
//

import Foundation
import SwiftUI
import Combine
enum ViewState {
    case loading
    case display
    case error
}
final class AstronomyViewModel: ObservableObject {
    
    @Published var state: ViewState = .loading
    @Published var apodDetails: AstronomyDetailsModel?
    
    let networkAPI = NetworkAPI.shared
    private var cancellable: AnyCancellable?
    
    private func buildAPODRequest() -> RequestBuilder {
        return ApodAPI.init(date: Date())
    }
    
    func getAPOD()  {
        state = .loading
        let jsonDecoder = JSONDecoder()
        cancellable =  networkAPI.perform(buildAPODRequest())
            .decode(type: APODJsonResponse.self, decoder: jsonDecoder)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] (result) in
                switch result {
                case .failure(let error):
                    self?.state = .error
                default:
                    break
                }
            }, receiveValue: { [weak self]  (result) in
                self?.state = .display
                self?.apodDetails = AstronomyDetailsModel.init(details: result)
            })
    }
}

struct APODJsonResponse : Codable {
    let copyright: String
    let date: String
    let explanation: String
    let hdurl: String
    let media_type: String
    let title: String
    let url: String
}
