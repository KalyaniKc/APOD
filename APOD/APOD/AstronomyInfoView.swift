//
//  ContentView.swift
//  APOD
//
//  Created by Kalyani Chinchane on 27/01/22.
//

import SwiftUI

struct AstronomyViewModel {
    var title: String
    var date: Date
    var image:URL
    var explanation: String
}

struct AstronomyInfoView: View {
    var body: some View {
        VStack {
            Image("sample")
                .resizable()
                .aspectRatio(UIImage(named: "sample")!.size, contentMode: .fill)
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height/2, alignment: .topLeading)
            ScrollView {
                VStack {
                    Text("Sample Title").font(.largeTitle).bold()
                    Text("TODAY").font(.title3).bold()
                }.foregroundColor(.white).padding()
                Text("Sample Description").font(.body).fontWeight(.medium).foregroundColor(.white)
            }
            Spacer()
        }.background(Color.black).edgesIgnoringSafeArea(.all)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        AstronomyInfoView()
    }
}
