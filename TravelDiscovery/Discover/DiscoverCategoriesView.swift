//
//  DiscoverCategoriesView.swift
//  TravelDiscovery
//
//  Created by Vasili on 24.02.22.
//

import SwiftUI
import Kingfisher

struct NavigationLazyView<Content: View>: View {
    let build: () -> Content
    init(_ build: @autoclosure @escaping () -> Content) {
        self.build = build
    }
    var body: Content {
        build()
    }
}

struct DiscoverCategoriesView: View {
    
    let categories: [Category] = [
        .init(name: "Art", imageName: "paintpalette.fill"),
        .init(name: "Sports", imageName: "sportscourt.fill"),
        .init(name: "Live events", imageName: "music.mic"),
        .init(name: "Food", imageName: "tray.fill"),
        .init(name: "History", imageName: "books.vertical.fill"),
    ]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(alignment: .top, spacing: 8) {
                ForEach(categories, id: \.self) { category in
                    NavigationLink {
                        NavigationLazyView(                        CategoryDetailsView(name: category.name))
                    } label: {
                        VStack {
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

                    
                }
            }.padding()
        }
    }
}




struct DiscoverCategoriesView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CategoryDetailsView(name: "ART")
        }
        DiscoverView()
    }
}
