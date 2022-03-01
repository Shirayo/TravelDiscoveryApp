//
//  PopularDestinationsView.swift
//  TravelDiscovery
//
//  Created by Vasili on 24.02.22.
//

import SwiftUI
import MapKit

struct PopularDestinationsView: View {

    let destinations: [Destination] = [
        .init(name: "Paris", country: "France", imageName: "parisCity", latitude: 48.85239723212344, longitude: 2.3401540989994407),
        .init(name: "Tokyo", country: "Japan", imageName: "tokyoCity", latitude: 35.67182352377911, longitude: 139.74923708313193),
        .init(name: "preikestolen", country: "Norway", imageName: "preikestolen", latitude: 58.986367087576895, longitude: 6.190324091555475),
        .init(name: "New York", country: "USA", imageName: "newYorkCity", latitude: 40.691931112588044, longitude: -74.02524836847729),
    ]
    
    var body: some View {
        VStack {
            HStack {
                Text("Popular destinations")
                    .font(.system(size: 14, weight: .semibold))
                Spacer()
                Text("see all")
                    .font(.system(size: 14, weight: .semibold))
            }.padding(.horizontal)
             .padding(.top)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    ForEach(destinations, id: \.self) { destination in
                        NavigationLink {
                            NavigationLazyView(PopularDestinationDetailsView(destination: destination))
//                            PopularDestinationDetailsView(destination: destination)
                        } label: {
                            PopularDestinationTile(destination: destination)
                        }

                    }
                }.padding(.horizontal)
            }
        }
    }
}

struct DestinationsDetails: Decodable {
    let photos: [String]
    let name, country, description: String
    let latitude, longitude: Double
    
}

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

struct PopularDestinationDetailsView: View {
    
    @ObservedObject var vm: DestinationDetailViewModel
    
    let destination: Destination
    let attractions: [Attraction] = [
        .init(name: "Eiffel Tower", imageName: "eiffel", latitude: 48.85770271275662, longitude: 2.29587771437089),
        .init(name: "Luvr", imageName: "luvr", latitude: 48.85994916746439, longitude: 2.3336456130850034),
    ]
    
    @State var region: MKCoordinateRegion
    @State var isShowingAttractions: Bool = true
    
    
    init(destination: Destination) {
        self.destination = destination
        self._region = State(initialValue: MKCoordinateRegion(center: .init(latitude: destination.latitude, longitude: destination.longitude), span: .init(latitudeDelta: 0.07, longitudeDelta: 0.07)))
        self.vm = .init(name: destination.name)
    }
    
    
    var body: some View {
        ScrollView {
            if let photos = vm.destinationDetails?.photos {
                DestinationHeaderContainer(imageUrlStrings: photos)
                    .frame(height: 300)
            }
            
            VStack(alignment: .leading) {
                Text(vm.destinationDetails?.name ?? "name")
                    .font(.system(size: 24, weight: .semibold))
                Text(vm.destinationDetails?.country ?? "country")
                    .font(.system(size: 20))
                
                HStack {
                    ForEach(0..<5) { el in
                        Image(systemName: "star.fill")
                            .foregroundColor(.yellow)
                    }
                }
                .padding(.vertical, 2)

                Text(vm.destinationDetails?.description ?? "")
                    .font(.system(size: 18, weight: .medium))
                
                HStack { Spacer() }
            }.padding(.horizontal)
            HStack {
                Text("Location")
                    .font(.system(size: 22, weight: .semibold))
                Spacer()
                Button {
                    isShowingAttractions.toggle()
                } label: {
                    Text( "\(isShowingAttractions ? "Hide attractions" : "Show attractions")")
                }
                Toggle("", isOn: $isShowingAttractions)
                    .labelsHidden()

            }
                .padding(.horizontal)
            
            Map(coordinateRegion: $region, annotationItems: isShowingAttractions ? attractions : []) { attraction in
                
                MapAnnotation(coordinate: .init(latitude: attraction.latitude, longitude: attraction.longitude)) {
                    CustomMapAnnotation(attraction: attraction)
                }
            }.frame(height: 300)
            
        }.navigationTitle(destination.name)
            .navigationBarTitleDisplayMode(.inline)
    }
        
}

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

struct Attraction: Identifiable {
    let id = UUID().uuidString
    
    let name, imageName: String
    let latitude, longitude: Double
}

struct PopularDestinationTile: View {
    
    let destination: Destination
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0){
            
            Image(destination.imageName)
                .resizable()
                .scaledToFill()
                .frame(width: 100, height: 100)
                .cornerRadius(4)
                .padding(.horizontal, 8)
                .padding(.vertical, 8)
            
            Text(destination.name)
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(Color(.label))
                .padding(.horizontal, 12)
            Text(destination.country)
                .font(.system(size: 14, weight: .semibold))
                .padding(.horizontal, 12)
                .padding(.bottom, 8)
                .foregroundColor(.gray)
        }
        .asTile()
    }
}

struct PopularDestinationsView_Previews : PreviewProvider {
    static var previews: some View {
        NavigationView {
            PopularDestinationDetailsView(destination: .init(name: "Paris", country: "France", imageName: "parisCity", latitude: 48.85239723212344, longitude: 2.3401540989994407))
        }
            .previewDevice("iPhone 13 Pro")
    }
}
