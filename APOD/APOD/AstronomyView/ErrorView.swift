//
//  ErrorView.swift
//  APOD
//
//  Created by Kalyani Chinchane on 30/01/22.
//

import SwiftUI

struct ErrorView: View {
    @State var errorText: String
    
    var body: some View {
        VStack(alignment: .center) {
        Text(errorText).font(.largeTitle)
            .bold().foregroundColor(.white)
            .accessibilityLabel("Error,,\(errorText)")
        }.padding()
    }
}
