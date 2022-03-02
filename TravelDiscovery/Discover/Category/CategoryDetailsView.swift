//
//  CategoryDetailsView.swift
//  TravelDiscovery
//
//  Created by Vasili on 25.02.22.
//

import SwiftUI
import Kingfisher

struct CategoryDetailsView: View {
    
    private let name: String
    @ObservedObject private var vm: CategoryDetailsViewModel
    
    init(name: String) {
        self.name = name
        self.vm = .init(name: name)
    }
        
    var body: some View {
        ZStack {
            if vm.isLoading {
                ActivityIndicatorView()
            } else {
                if vm.errorMessage.isEmpty {
                    ScrollView {
                        ForEach(vm.places, id: \.self) { place in
                            VStack(alignment: .leading, spacing: 0) {
                                KFImage(URL(string: place.thumbnail))
                                    .resizable()
                                    .scaledToFill()
                                Text(place.name)
                                    .font(.system(size: 12, weight: .semibold))
                                    .padding()
                            }.asTile()
                                .padding()
                        }
                    }.navigationTitle(name)
                        .navigationBarTitleDisplayMode(.inline)
                } else {
                    VStack {
                        Image(systemName: "xmark.octagon.fill")
                            .font(.system(size: 72, weight: .semibold))
                            .foregroundColor(.red)
                        Text(vm.errorMessage)
                            .font(.system(size: 24, weight: .semibold))

                    }
                }
            }
        }
    }
}

struct CategoryDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CategoryDetailsView(name: "live events")
        }
    }
}
