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
                ErrorView(errorText: "Something went wrong")
            }
        }.frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height).background(Color.black).edgesIgnoringSafeArea(.all)
            .onAppear{
                viewModel.getAPOD(for: Date.yesterday)
            }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        AstronomyInfoView()
    }
}

extension Date {
    static var yesterday: Date { return Date().dayBefore }
    static var tomorrow:  Date { return Date().dayAfter }
    var dayBefore: Date {
        return Calendar.current.date(byAdding: .day, value: -1, to: noon)!
    }
    var dayAfter: Date {
        return Calendar.current.date(byAdding: .day, value: 1, to: noon)!
    }
    var noon: Date {
        return Calendar.current.date(bySettingHour: 12, minute: 0, second: 0, of: self)!
    }
    var month: Int {
        return Calendar.current.component(.month,  from: self)
    }
    var isLastDayOfMonth: Bool {
        return dayAfter.month != month
    }
}
