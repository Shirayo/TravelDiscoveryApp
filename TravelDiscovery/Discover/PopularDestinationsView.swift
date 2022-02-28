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
                        NavigationLink {
                            PopularDestinationView(destination: destination)
                        } label: {
                            PopularDestinationTile(destination: destination)
                        }

                    }
                }.padding(.horizontal)
            }
        }
    }
}

struct PopularDestinationView: View {
    
    let destination: Destination
    
    var body: some View {
        ScrollView {
            Image(destination.imageName)
                .resizable()
                .scaledToFill()
            VStack(alignment: .leading) {
                Text(destination.name)
                Text(destination.country)
                
                HStack {
                    ForEach(0..<5) { el in
                        Image(systemName: "star.fill")
                            .foregroundColor(.yellow)
                    }
                }
                .padding(.top, 4)

                Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.")
                
                HStack { Spacer() }
            }.padding(.horizontal)
        }.navigationTitle(destination.name)
            .navigationBarTitleDisplayMode(.inline)
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
    }
}

struct PopularDestinationsView_Previews : PreviewProvider {
    static var previews: some View {
        NavigationView {
            PopularDestinationView(destination: .init(name: "paris", country: "france", imageName: "parisCity"))
        }
            .previewDevice("iPhone 13 Pro")
    }
}
