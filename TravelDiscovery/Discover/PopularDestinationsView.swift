//
//  PopularDestinationsView.swift
//  TravelDiscovery
//
//  Created by Vasili on 24.02.22.
//

import SwiftUI

struct PopularDestinationsView: View {
    
    let destinations: [Destination] = [
        .init(name: "Paris", country: "France", imageName: "parisCity"),
        .init(name: "Tokyo", country: "Japan", imageName: "tokyoCity"),
        .init(name: "preikestolen", country: "Norway", imageName: "preikestolen"),
        .init(name: "New York", country: "USA", imageName: "newYorkCity"),

    ]
    
    var body: some View {
        VStack {
            HStack {
                Text("Popular destinations")
                    .font(.system(size: 14, weight: .semibold))
                Spacer()
                Text("see all")
                    .font(.system(size: 14, weight: .semibold))
            }.padding(.horizontal)
             .padding(.top)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    ForEach(destinations, id: \.self) { destination in
                        VStack(alignment: .leading, spacing: 0){
                            
                            Image(destination.imageName)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 100, height: 100)
                                .cornerRadius(4)
                                .padding(.horizontal, 8)
                                .padding(.vertical, 8)
                            
                            Text(destination.name)
                                .font(.system(size: 14, weight: .semibold))
                                .padding(.horizontal, 12)
                            Text(destination.country)
                                .font(.system(size: 14, weight: .semibold))
                                .padding(.horizontal, 12)
                                .padding(.bottom, 8)
                                .foregroundColor(.gray)
                        }
                        .background(.white)
                            .cornerRadius(5)
                            .shadow(color: .gray, radius: 4, x: 0, y: 2)
                            .padding(.bottom)
                    }
                }.padding(.horizontal)
            }
        }
    }
}

struct PopularDestinationsView_Previews : PreviewProvider {
    static var previews: some View {
        PopularDestinationsView()
            .previewDevice("iPhone 13 Pro")
    }
}
