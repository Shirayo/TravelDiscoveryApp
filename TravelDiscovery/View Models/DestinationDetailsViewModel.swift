//
//  DestinationDetailsViewModel.swift
//  TravelDiscovery
//
//  Created by Vasili on 1.03.22.
//

import Foundation

class DestinationDetailViewModel: ObservableObject {
    @Published var isLoading = true
    @Published var destinationDetails: DestinationsDetails?
    init(name: String) {
        print(name.lowercased())
        guard let url = URL(string: "https://travel.letsbuildthatapp.com/travel_discovery/destination?name=\(name.lowercased())".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "") else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                if let data = data {
                    do {
                        self.destinationDetails = try JSONDecoder().decode(DestinationsDetails.self, from: data)
                    } catch {
                        
                    }
                }
            }
        }.resume()
    }
}
