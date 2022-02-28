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
    
//    @ObservedObject var vm = CategoryDetailsViewModel()
//    let name: String
    
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

class CategoryDetailsViewModel: ObservableObject {
    @Published var isLoading = true
    @Published var places = [Place]()
    @Published var errorMessage = ""
    init(name: String) {
        let urlString = "https://travel.letsbuildthatapp.com/travel_discovery/category?name=\(name.lowercased())".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        guard let url = URL(string: urlString) else {
            self.isLoading = false
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                if let statusCode = (response as? HTTPURLResponse)?.statusCode,  statusCode >= 400 {
                    self.isLoading = false
                    self.errorMessage = "Bad status: \(statusCode)"
                    return
                }
                guard let data = data else {
                    print("guard")
                    return
                }
                
                do {
                    self.places = try JSONDecoder().decode([Place].self, from: data)
                } catch {
                    print("Failed to decode JSON: ", error)
                    self.errorMessage = error.localizedDescription
                }
                self.isLoading = false
            }
           
        }.resume()
        
    }
}


struct CategoryDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CategoryDetailsView(name: "live events")
        }
    }
}