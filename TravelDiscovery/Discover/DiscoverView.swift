//
//  ContentView.swift
//  TravelDiscovery
//
//  Created by Vasili on 24.02.22.
//

import SwiftUI

extension Color {
   static let discoverColor = Color(.init(white: 0.95, alpha: 1))
}

struct DiscoverView: View {
    
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [
            .foregroundColor: UIColor.white
        ]
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(colors: [Color(red: 255/255, green: 193/255, blue: 0/255), Color(red: 1, green: 77/255, blue: 0/255)], startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
                
                Color.discoverColor.offset(y: 400)
                
                ScrollView {
                    DiscoverCategoriesView()
                    VStack {
                        PopularDestinationsView()
                        PopularRestaurantsView()
                        TrendingCreatorsView()
                    }.background(Color.discoverColor)
                        .cornerRadius(16)
                        .padding(.top, 32)
                    
                }.navigationTitle("Discover")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        DiscoverView()
            .previewDevice("iPhone 13 Pro")
    }
}
