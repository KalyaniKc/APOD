//
//  AstronomyDetailsModel.swift
//  APOD
//
//  Created by Kalyani Chinchane on 29/01/22.
//

import Foundation
struct AstronomyDetailsModel {
    var title: String
    var date: String
    var image: String
    var explanation: String
    var mediaType: APODMediaType
    
    init(details: APODJsonResponse) {
        self.title = details.title
        self.date = details.date
        self.image = details.url
        self.mediaType = details.media_type
        self.explanation = details.explanation
    }
}
