//
//  Attraction.swift
//  TravelDiscovery
//
//  Created by Vasili on 1.03.22.
//

import Foundation

struct Attraction: Identifiable {
    let id = UUID().uuidString
    
    let name, imageName: String
    let latitude, longitude: Double
}
