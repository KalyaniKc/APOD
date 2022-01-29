//
//  LoadingView.swift
//  APOD
//
//  Created by Kalyani Chinchane on 29/01/22.
//

import Foundation
import SwiftUI

struct LoadingView: View {
    var body: some View {
        ZStack {
            Color(.black).edgesIgnoringSafeArea(.all)
            ProgressView().progressViewStyle(CircularProgressViewStyle(tint: .gray))
                .scaleEffect(2)
        }
    }
}
