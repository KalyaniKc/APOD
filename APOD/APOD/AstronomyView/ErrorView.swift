//
//  ErrorView.swift
//  APOD
//
//  Created by Kalyani Chinchane on 30/01/22.
//

import SwiftUI

struct ErrorView: View {
    @State var errorText: String
    @Binding var showDatePicker: Bool
    var body: some View {
        VStack(alignment: .center) {
        Text(errorText).font(.largeTitle)
            .bold()
            .accessibilityLabel("Error,,\(errorText)")
            Button(action: {
                showDatePicker.toggle()
            }) {
                Text("Select Date")
                    .font(.title3)
                    .fontWeight(.regular)
                    .multilineTextAlignment(.center)
                    .frame(width: 280, height: 50,
                           alignment: .center)
                    .background(Color.red)
                    .cornerRadius(15)
            }
        }.padding().foregroundColor(.white)
    }
}
