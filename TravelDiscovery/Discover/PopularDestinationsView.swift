//
//  PopularDestinationsView.swift
//  TravelDiscovery
//
//  Created by Vasili on 24.02.22.
//

import SwiftUI
import MapKit

struct PopularDestinationsView: View {
    //    48.85239723212344, 2.3401540989994407
//    35.67182352377911, 139.74923708313193
//    58.986367087576895, 6.190324091555475
//    40.691931112588044, -74.02524836847729
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
                            PopularDestinationView(destination: destination)
                        } label: {
                            PopularDestinationTile(destination: destination)
                        }

                    }
                }.padding(.horizontal)
            }
        }
    }
}

struct PopularDestinationView: View {
    
    let destination: Destination
    let attractions: [Attraction] = [
        .init(name: "Eiffel Tower", latitude: 48.85770271275662, longitude: 2.29587771437089),
        .init(name: "Luvr", latitude: 48.85994916746439, longitude: 2.3336456130850034),
    ]
//    48.85770271275662, 2.29587771437089
//    48.85994916746439, 2.3336456130850034
    @State var region: MKCoordinateRegion
    @State var isShowingAttractions: Bool = true
    
    
    init(destination: Destination) {
        self.destination = destination
        self._region = State(initialValue: MKCoordinateRegion(center: .init(latitude: destination.latitude, longitude: destination.longitude), span: .init(latitudeDelta: 0.1, longitudeDelta: 0.1))) 
    }
    
    var body: some View {
        ScrollView {
            Image(destination.imageName)
                .resizable()
                .scaledToFill()
            VStack(alignment: .leading) {
                Text(destination.name)
                    .font(.system(size: 24, weight: .semibold))
                Text(destination.country)
                    .font(.system(size: 20))
                
                HStack {
                    ForEach(0..<5) { el in
                        Image(systemName: "star.fill")
                            .foregroundColor(.yellow)
                    }
                }
                .padding(.vertical, 2)

                Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.")
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
                MapMarker(coordinate: .init(latitude: attraction.latitude, longitude: attraction.longitude), tint: .red)
            }.frame(height: 300)
            
        }.navigationTitle(destination.name)
            .navigationBarTitleDisplayMode(.inline)
    }
        
}

struct Attraction: Identifiable {
    let id = UUID().uuidString
    
    let name: String
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
            PopularDestinationView(destination: .init(name: "Paris", country: "France", imageName: "parisCity", latitude: 48.85239723212344, longitude: 2.3401540989994407))
        }
            .previewDevice("iPhone 13 Pro")
    }
}
