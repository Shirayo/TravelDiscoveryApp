//
//  DestinationDetails.swift
//  TravelDiscovery
//
//  Created by Vasili on 1.03.22.
//

import Foundation

struct DestinationsDetails: Decodable {
    let photos: [String]
    let name, country, description: String
    let latitude, longitude: Double
    
}
