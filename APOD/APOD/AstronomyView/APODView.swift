//
//  APODView.swift
//  APOD
//
//  Created by Kalyani Chinchane on 30/01/22.
//

import SwiftUI

struct APODView: View {
    @State var detail: AstronomyDetailsModel
    @State var showDatePicker: Bool = false
    @Binding var savedDate: Date?
    struct ImgView: View {
        @State var imgURL: URL
        var body: some View {
            APODImageView(url: imgURL,
                          placeholder: {
                VStack(alignment: .center){
                    LoadingView()
                }.padding()
            }).aspectRatio(contentMode: .fit)
        }
    }
    
    var body: some View {
        VStack {
            VStack {
                if detail.mediaType == .image {
                    if let imgURL = URL(string: detail.image) {
                        ImgView(imgURL: imgURL)
                    }
                } else {
                    // add video view
                    if let imgURL = URL(string: detail.image) {
                        VStack(alignment: .center) {
                            Link(destination: imgURL) {
                                Label("Play", systemImage: "play.circle")
                                    .font(.title3)
                                    .multilineTextAlignment(.center)
                            }
                        }.padding(EdgeInsets(top: 50, leading: 50, bottom: 50, trailing: 50))
                    }
                }
            }.frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height/2, alignment: .center)
            ScrollView {
                VStack {
                    //title
                    Text(detail.title).font(.largeTitle)
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.center)
                    //date
                    Button(action: {
                        showDatePicker.toggle()
                    }) {
                        Text(detail.date)
                            .font(.title3)
                            .fontWeight(.regular)
                            .multilineTextAlignment(.center)
                            .frame(width: 280, height: 50, alignment: .center).background(Color.red).cornerRadius(15)
                    }
                }.foregroundColor(.white).padding()
                //description
                Text(detail.explanation).font(.body).fontWeight(.medium).foregroundColor(.white).multilineTextAlignment(.leading)
            }
            Spacer()
            if showDatePicker {
                VStack {
                    DatePickerView(showDatePicker: $showDatePicker, savedDate: $savedDate)
                }
            }
        }
    }
}
