//
//  AllPhotosView.swift
//  TravelDiscovery
//
//  Created by Vasili on 1.03.22.
//

import SwiftUI
import Kingfisher

struct AllPhotosView: View {
    
    @State var modee = "grid"
    @State var isOpened = false
    @State var chosenPhotoIndex = 0
    //this changes every UISegmentedControl in your application
    init() {
        UISegmentedControl.appearance().backgroundColor = .lightGray
        UISegmentedControl.appearance().selectedSegmentTintColor = .orange
        let titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        UISegmentedControl.appearance().setTitleTextAttributes(titleTextAttributes, for: .normal)
        UISegmentedControl.appearance().setTitleTextAttributes(titleTextAttributes, for: .selected)
    }
    
    var body: some View {
        let photos = [
            "https://letsbuildthatapp-videos.s3.us-west-2.amazonaws.com/92bb86e7-5417-4450-9870-cae93cfd33c4",
            "https://letsbuildthatapp-videos.s3.us-west-2.amazonaws.com/4116ad7a-78fe-41b5-97e2-82b0748885d9",
            "https://letsbuildthatapp-videos.s3.us-west-2.amazonaws.com/def50b63-fc4e-4ca0-9d14-69f2ee3b661a",
            "https://letsbuildthatapp-videos.s3.us-west-2.amazonaws.com/9777b95e-fdae-4664-9ca5-394761e3312d",
            "https://letsbuildthatapp-videos.s3.us-west-2.amazonaws.com/3b57304a-723c-48b2-8ad8-82c204297c5d",
            "https://letsbuildthatapp-videos.s3.us-west-2.amazonaws.com/abc458e6-1d7f-4e6b-8e90-a7e35b0d45aa",
            "https://letsbuildthatapp-videos.s3.us-west-2.amazonaws.com/0398dcab-7836-47e4-92ff-d41a262465eb"
        ]
        
        GeometryReader { proxy in
            ScrollView {
                
                Picker("TEXT", selection: $modee) {
                    Text("Grid").tag("grid")
                    Text("List").tag("list")
                }.pickerStyle(.segmented)
                    .padding()
                
                Spacer()
                    .fullScreenCover(isPresented: $isOpened, content: {
                        ZStack(alignment: .topLeading){
                            //...
                            Color.black.ignoresSafeArea()
                            DestinationHeaderContainer(imageUrlStrings: photos, chosenPhotoIndex: chosenPhotoIndex)
                            Button {
                                isOpened.toggle()
                            } label: {
                                Image(systemName: "xmark")
                                    .font(.system(size: 32, weight: .bold))
                                    .foregroundColor(.white)
                                    .padding()
                            }

                        }
                    })
                    .opacity(isOpened ? 1 : 0)
                
                
                if modee == "grid" {
                    LazyVGrid(columns: [
                        GridItem(.adaptive(minimum: proxy.size.width / 3, maximum: 600), spacing: 0),
                    ], spacing: 2, content: {
                        ForEach(photos, id: \.self) { photo in
                            Button {
                                chosenPhotoIndex = photos.firstIndex(of: photo) ?? 0
                                isOpened.toggle()
                            } label: {
                                KFImage(URL(string: photo))
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: proxy.size.width / 3 - 2, height: proxy.size.width / 3 - 2)
                                    .clipped()
                                    .cornerRadius(2)
                                
                            }
                        }
                    })
                } else {
                    ForEach(photos, id: \.self) { photo in
                        VStack(alignment: .leading) {
                            KFImage(URL(string: photo))
                                .resizable()
                                .scaledToFill()
                            HStack {
                                Image(systemName: "heart")
                                Image(systemName: "bubble.right")
                                Image(systemName: "paperplane")
                                Spacer()
                                Image(systemName: "bookmark")
                            }.padding(.horizontal, 8)
                                .font(.system(size: 18))
                            Text("hewqp'e pwefj jw;lekfwo welfeh jej ee ;'askefjefh w e;fjhwe ;ohw")
                                .font(.system(size: 14))
                                .padding(.horizontal, 8)
                            Text("posted on 02/03/2022")
                                .font(.system(size: 14))
                                .padding(.horizontal, 8)
                                .foregroundColor(.gray)
                        }.padding(.bottom)
                    }
                }
                
            }.navigationTitle("All Photos")
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct AllPhotosView_Previews: PreviewProvider {
    static var previews: some View {
        AllPhotosView()
    }
}
