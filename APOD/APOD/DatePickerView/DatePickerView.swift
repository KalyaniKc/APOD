//
//  DatePickerView.swift
//  APOD
//
//  Created by Kalyani Chinchane on 30/01/22.
//

import SwiftUI

struct DatePickerView: View {
    @Binding var showDatePicker: Bool
    @Binding var savedDate: Date?
    @State var selectedDate: Date = Date()
    var body: some View {
        VStack {
            VStack {
                DatePicker("Test", selection: $selectedDate, displayedComponents: [.date])
                    .datePickerStyle(.graphical)
                    .background(Color.blue)
                    .cornerRadius(10)
                    .accentColor(.white)
                    .animation(.linear)
                    .transition(.opacity)
                
                Divider()
                HStack {
                    
                    Button(action: {
                        showDatePicker = false
                    }, label: {
                        Text("Cancel")
                    })
                    
                    Spacer()
                    
                    Button(action: {
                        savedDate = selectedDate
                        showDatePicker = false
                    }, label: {
                        Text("Save".uppercased())
                            .bold()
                    })
                    
                }
                .padding(.horizontal)
            }
        }
        .padding(EdgeInsets.init(top: 30, leading: 40, bottom: 120, trailing: 50)).background(Color.gray.opacity(0.1))
    }
}
