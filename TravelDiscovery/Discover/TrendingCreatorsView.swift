//
//  TrendingCreatorsView.swift
//  TravelDiscovery
//
//  Created by Vasili on 24.02.22.
//

import SwiftUI

struct TrendingCreatorsView: View {
    
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

struct TrendingCreatorsView_Previews: PreviewProvider {
    static var previews: some View {
        TrendingCreatorsView()
    }
}
