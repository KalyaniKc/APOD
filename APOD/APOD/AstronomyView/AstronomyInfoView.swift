//
//  ContentView.swift
//  APOD
//
//  Created by Kalyani Chinchane on 27/01/22.
//

import SwiftUI

struct AstronomyInfoView: View {
    @ObservedObject var viewModel = AstronomyViewModel()
    @State var updatedDate: Date? {
        didSet {
            viewModel.selectedDate = updatedDate!
        }
    }
    @State var showDatePickerForError: Bool = false
    
    private var loader = LoadingView()
    
    var body: some View {
        VStack {
            if viewModel.state == .loading {
                LoadingView()
            } else if viewModel.state == .display,
                      let detail = viewModel.apodDetails  {
                APODView(detail:detail,
                         savedDate: $viewModel.selectedDate)
            } else {
                if showDatePickerForError {
                    VStack {
                        DatePickerView(showDatePicker: $showDatePickerForError, savedDate: $viewModel.selectedDate)
                    }
                } else {
                    ErrorView(errorText: "Something went wrong. Please select another date",
                              showDatePicker: $showDatePickerForError)
                }
            }
        }.frame(width: UIScreen.main.bounds.width,
                height: UIScreen.main.bounds.height)
            .background(Color.black).edgesIgnoringSafeArea(.all)
            .onAppear{
                viewModel.getAPOD(for: Date())
            }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        AstronomyInfoView()
    }
}
