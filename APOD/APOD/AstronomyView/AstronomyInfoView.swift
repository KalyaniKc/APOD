//
//  ContentView.swift
//  APOD
//
//  Created by Kalyani Chinchane on 27/01/22.
//

import SwiftUI

struct AstronomyInfoView: View {
    @StateObject var viewModel = AstronomyViewModel()
    private var loader = LoadingView()
    
    var body: some View {
        VStack {
            if viewModel.state == .loading {
                LoadingView()
            } else if viewModel.state == .display,
                      let detail = viewModel.apodDetails  {
                APODView(detail:detail)
            } else {
                Text("Something went wrong")
            }
        }.background(Color.black).edgesIgnoringSafeArea(.all)
            .onAppear{
                viewModel.getAPOD()
            }
    }
}

struct APODView: View {
    @State var detail: AstronomyDetailsModel
    var body: some View {
        Image("sample")
            .resizable()
            .aspectRatio(UIImage(named: "sample")!.size, contentMode: .fill)
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height/2, alignment: .topLeading)
        ScrollView {
            VStack {
                Text(detail.title).font(.largeTitle).bold()
                Text(detail.date).font(.title3).bold()
            }.foregroundColor(.white).padding()
            Text(detail.explanation).font(.body).fontWeight(.medium).foregroundColor(.white)
        }
        Spacer()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        AstronomyInfoView()
    }
}
