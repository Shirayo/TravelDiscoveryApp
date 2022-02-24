//
//  DiscoverCategoriesView.swift
//  TravelDiscovery
//
//  Created by Vasili on 24.02.22.
//

import SwiftUI

struct DiscoverCategoriesView: View {
    
    let categories: [Category] = [
        .init(name: "Art", imageName: "paintpalette.fill"),
        .init(name: "Sport", imageName: "sportscourt.fill"),
        .init(name: "Live events", imageName: "music.mic"),
        .init(name: "Food", imageName: "music.mic"),
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
                            .foregroundColor(Color(red: 1, green: 154/255, blue: 0/255))
                            .frame(width: 70, height: 70)
                            .background(.white)
                            .cornerRadius(.infinity)
                            .shadow(color: .gray, radius: 5, x: 0, y: 0)
                        Text(category.name)
                            .foregroundColor(.white)
                            .font(.system(size: 16, weight: .semibold))
                            .multilineTextAlignment(.center)
                    }
                    
                }
            }.padding()
        }
    }
}

struct DiscoverCategoriesView_Previews: PreviewProvider {
    static var previews: some View {
        DiscoverCategoriesView()
    }
}
