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
protocol APODViewModelDelegate: AnyObject {
    func getAPOD(for date: Date)
    var state: ViewState { get set }
    var apodDetails: AstronomyDetailsModel? { get set }
}
final class AstronomyViewModel: APODViewModelDelegate, ObservableObject {
    
    @Published var state: ViewState = .loading
    @Published var apodDetails: AstronomyDetailsModel?
    @Published var selectedDate: Date? {
        didSet {
            if oldValue != selectedDate {
                if let d = selectedDate {
                    getAPOD(for: d)
                }
            }
        }
    }
    private var lastSuccessfulResult: AstronomyDetailsModel?
    
    let networkAPI = NetworkAPI.shared
    private var cancellable: AnyCancellable?
    
    private func buildAPODRequest(date: Date) -> RequestBuilder {
        return ApodAPI.init(date: date)
    }
    
    func getAPOD(for date: Date)  {
        state = .loading
        let jsonDecoder = JSONDecoder()
        cancellable =  networkAPI.perform(buildAPODRequest(date: date))
            .decode(type: APODJsonResponse.self, decoder: jsonDecoder)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] (result) in
                switch result {
                case .failure:
                    if let detail = self?.lastSuccessfulResult {
                        self?.state = .display
                        self?.apodDetails = detail
                    } else {
                        self?.state = .error
                    }
                default:
                    break
                }
            }, receiveValue: { [weak self]  (result) in
                self?.state = .display
                self?.apodDetails = AstronomyDetailsModel.init(details: result)
                self?.lastSuccessfulResult = self?.apodDetails
            })
    }
}
