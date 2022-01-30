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
                ErrorView(errorText: "Something went wrong")
            }
        }.frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height).background(Color.black).edgesIgnoringSafeArea(.all)
            .onAppear{
                viewModel.getAPOD()
            }
    }
}

struct ErrorView: View {
    @State var errorText: String
    
    var body: some View {
        Text(errorText).font(.largeTitle).bold().foregroundColor(.white).accessibilityLabel("Error,,\(errorText)")
    }
}

struct APODView: View {
    @State var detail: AstronomyDetailsModel
    var body: some View {
        VStack {
            if let imgURL = URL(string: detail.image) {
                APODImageView(url: imgURL,
                              placeholder: {
                    VStack(alignment: .center){
                        LoadingView()
                    }.padding()
                }).aspectRatio(contentMode: .fit)
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height/2, alignment: .topLeading)
            }
            ScrollView {
                VStack {
                    //title
                    Text(detail.title).font(.largeTitle).fontWeight(.semibold).multilineTextAlignment(.center)
                    //date
                    Text(detail.date).font(.title3).fontWeight(.regular).multilineTextAlignment(.center)
                }.foregroundColor(.white).padding()
                //description
                Text(detail.explanation).font(.body).fontWeight(.medium).foregroundColor(.white).multilineTextAlignment(.leading)
            }
            Spacer()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        AstronomyInfoView()
    }
}
