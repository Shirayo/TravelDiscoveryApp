//
//  PopularDestinationDetailsView.swift
//  TravelDiscovery
//
//  Created by Vasili on 1.03.22.
//

import SwiftUI
import MapKit

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
                DestinationHeaderContainer(imageUrlStrings: photos, chosenPhotoIndex: 0)
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

//struct PopularDestinationDetailsView_Previews: PreviewProvider {
//    static var previews: some View {
//       PopularDestinationDetailsView(destination: )
//    }
//}
