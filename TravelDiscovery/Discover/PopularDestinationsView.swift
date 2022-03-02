//
//  PopularDestinationsView.swift
//  TravelDiscovery
//
//  Created by Vasili on 24.02.22.
//

import SwiftUI
import MapKit

struct PopularDestinationsView: View {

    let destinations: [Destination] = [
        .init(name: "Paris", country: "France", imageName: "parisCity", latitude: 48.85239723212344, longitude: 2.3401540989994407),
        .init(name: "Tokyo", country: "Japan", imageName: "tokyoCity", latitude: 35.67182352377911, longitude: 139.74923708313193),
        .init(name: "preikestolen", country: "Norway", imageName: "preikestolen", latitude: 58.986367087576895, longitude: 6.190324091555475),
        .init(name: "New York", country: "USA", imageName: "newYorkCity", latitude: 40.691931112588044, longitude: -74.02524836847729),
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
                        NavigationLink {
                            NavigationLazyView(PopularDestinationDetailsView(destination: destination))
                        } label: {
                            PopularDestinationTile(destination: destination)
                        }

                    }
                }.padding(.horizontal)
            }
        }
    }
}


struct PopularDestinationTile: View {
    
    let destination: Destination
    
    var body: some View {
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
                .foregroundColor(Color(.label))
                .padding(.horizontal, 12)
            Text(destination.country)
                .font(.system(size: 14, weight: .semibold))
                .padding(.horizontal, 12)
                .padding(.bottom, 8)
                .foregroundColor(.gray)
        }
        .asTile()
        .padding(.vertical)
    }
}

struct PopularDestinationsView_Previews : PreviewProvider {
    static var previews: some View {
        NavigationView {
            PopularDestinationDetailsView(destination: .init(name: "Paris", country: "France", imageName: "parisCity", latitude: 48.85239723212344, longitude: 2.3401540989994407))
        }
            .previewDevice("iPhone 13 Pro")
    }
}
