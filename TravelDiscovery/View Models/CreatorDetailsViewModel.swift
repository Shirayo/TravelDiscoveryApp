//
//  CreatorDetailsViewModel.swift
//  TravelDiscovery
//
//  Created by Vasili on 3.03.22.
//

import Foundation

class CreatorDetailsViewModel: ObservableObject {
    @Published var isLoaded = false
    @Published var creator: CreatorDetails?
    
    init(id: Int) {
        guard let url = URL(string: "https://travel.letsbuildthatapp.com/travel_discovery/user?id=\(id)") else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                guard let data = data else {
                    print("no data")
                    return
                }
                do {
                    self.creator = try JSONDecoder().decode(CreatorDetails.self, from: data)
                } catch {
                    print("error")
                }
            }
        }.resume()
    }
}
