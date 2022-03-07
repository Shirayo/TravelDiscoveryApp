//
//  PopularRestarantsView.swift
//  TravelDiscovery
//
//  Created by Vasili on 24.02.22.
//

import SwiftUI

struct PopularRestaurantsView: View {
    
    let restaurants: [Restaurant] = [
        .init(name: "Japan's Finest Tapas", imageName: "tapas", id: 0),
        .init(name: "Bar & Grill", imageName: "barGrill", id: 1),
    ]
    
    var body: some View {
        VStack {
            HStack {
                Text("Popular restaurants")
                    .font(.system(size: 14, weight: .semibold))
                Spacer()
                Text("see all")
                    .font(.system(size: 14, weight: .semibold))
            }.padding(.horizontal)
                .padding(.top)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 8) {
                    ForEach(restaurants, id: \.self) { restaurant in
                        NavigationLink {
                            RestaurantDetailsView(restaurant: restaurant)
                        } label: {
                            PopularRestaurantsTile(restaurant: restaurant)

                        }

                    }
                }.padding(.horizontal)
            }
        }
    }
}

struct PopularRestaurantsTile: View {
    
    let restaurant: Restaurant
    
    var body: some View {
        HStack{
            Image(restaurant.imageName)
                .resizable()
                .cornerRadius(2)
                .scaledToFill()
                .frame(width: 64, height: 64)
                .clipped()
                .padding(.leading, 6)
                .padding(.vertical, 6)
            VStack(alignment: .leading, spacing: 6) {
                HStack {
                    Text(restaurant.name)
                    Spacer()
                    Button {
                        print("smh")
                    } label: {
                        Image(systemName: "ellipsis")
                    }
                    .foregroundColor(.gray)
                }
                HStack {
                    Image(systemName: "star.fill")
                    Text("4.7 • Sushi • $$")
                }
                Text("Tokyo, Japan")
            }.font(.system(size: 12, weight: .semibold))
                .foregroundColor(.black)
                .padding(.leading, 8)
            
            Spacer()
        }.frame(width: 240)
            .asTile()
            .padding(.vertical)
    }
}

struct PopularRestaurantsView_Previews: PreviewProvider {
    static var previews: some View {
        PopularRestaurantsView()
    }
}
