//
//  CustomMapAnnotation.swift
//  TravelDiscovery
//
//  Created by Vasili on 1.03.22.
//

import SwiftUI

struct CustomMapAnnotation: View {
    
    let attraction: Attraction
    
    var body: some View {
        VStack {
            Image(attraction.imageName)
                .resizable()
                .scaledToFill()
                .frame(width: 80, height: 60, alignment: .center)
                .cornerRadius(6)
            Text(attraction.name)
                .padding(.horizontal, 6)
                .padding(.vertical, 4)
                .background(LinearGradient(colors: [.orange, .red], startPoint: .leading, endPoint: .trailing))
                .foregroundColor(.white)
                .cornerRadius(6)
        }
    }
}
