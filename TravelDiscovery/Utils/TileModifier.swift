//
//  TileModifier.swift
//  TravelDiscovery
//
//  Created by Vasili on 25.02.22.
//

import SwiftUI

extension View {
    func asTile() -> some View {
        modifier(TileModifier())
    }
}

struct TileModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(.white)
            .cornerRadius(5)
            .shadow(color: .gray, radius: 4, x: 0, y: 2)
            .padding(.vertical)
    }
}
