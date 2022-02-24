//
//  ContentView.swift
//  TravelDiscovery
//
//  Created by Vasili on 24.02.22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            ScrollView {
                DiscoverCategoriesView()
                PopularDestinationsView()
                PopularRestaurantsView()
                TrendingCreators()
            }.navigationTitle("Discover")
                
        }
    }
}

struct Destination: Hashable {
    let name, country, imageName: String
}

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
                            .background(Color(.init(white: 0.9, alpha: 1)))
                            .cornerRadius(5)
                            .shadow(color: .gray, radius: 4, x: 0, y: 2)
                            .padding(.bottom)
                    }
                }.padding(.horizontal)
            }
        }
    }
}

struct Restaurant: Hashable {
    let name, imageName: String
}

struct PopularRestaurantsView: View {
    
    let restaurants: [Restaurant] = [
        .init(name: "Japan's Finest Tapas", imageName: "tapas"),
        .init(name: "Bar & Grill", imageName: "barGrill"),
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
                                .padding(.leading, 8)
                            
                            Spacer()
                        }.frame(width: 240)
                            .background(Color(.init(white: 0.9, alpha: 1)))
                            .cornerRadius(5)
                            .shadow(color: .gray, radius: 4, x: 0, y: 2)
                            .padding(.bottom)
                    }
                }.padding(.horizontal)
            }
        }
    }
}

struct Creator: Hashable {
    let fullName, imageName: String
}

struct TrendingCreators: View {
    
    let creators: [Creator] = [
        .init(fullName: "Amy Adams", imageName: "amy"),
        .init(fullName: "Billy Childs", imageName: "billy"),
        .init(fullName: "Sam Smith", imageName: "sam")
    ]
    
    var body: some View {
        VStack {
            HStack {
                Text("Trending Creators")
                    .font(.system(size: 14, weight: .semibold))
                Spacer()
                Text("see all")
                    .font(.system(size: 14, weight: .semibold))
            }.padding(.horizontal)
                .padding(.top)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .top, spacing: 8) {
                    ForEach(creators, id: \.self) { num in
                        VStack {
                            Image(num.imageName)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 70, height: 70)
                                .cornerRadius(.infinity)
                                .shadow(color: .gray, radius: 4, x: 0, y: 2)
                            Text(num.fullName)
                                .font(.system(size: 14, weight: .semibold))
                                .multilineTextAlignment(.center)
                        }
                        .frame(width: 70)
                       
                    }
                }.padding(.horizontal)
            }
        }
    }
}
struct Category: Hashable {
    let name, imageName: String
}

struct DiscoverCategoriesView: View {
    
    let categories: [Category] = [
        .init(name: "Art", imageName: "paintpalette.fill"),
        .init(name: "Sport", imageName: "sportscourt.fill"),
        .init(name: "Live events", imageName: "music.mic"),
        .init(name: "Food", imageName: "palette"),
        .init(name: "History", imageName: "books.vertical.fill"),
    ]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(alignment: .top, spacing: 8) {
                ForEach(categories, id: \.self) { category in
                    VStack {
//                        Spacer()
                        Image(systemName: category.imageName)
                            .font(.system(size: 24))
                            .foregroundColor(.white)
                            .frame(width: 70, height: 70)
                            .background(Color .gray)
                            .cornerRadius(.infinity)
                            .shadow(color: .gray, radius: 5, x: 0, y: 0)
                        Text(category.name)
                    }.frame(width: 80)
                    
                }
            }.padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewDevice("iPhone 13 Pro")
    }
}
