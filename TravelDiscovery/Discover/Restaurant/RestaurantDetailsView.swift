//
//  RestaurantDetailsView.swift
//  TravelDiscovery
//
//  Created by Vasili on 1.03.22.
//

import SwiftUI
import Kingfisher

class RestaurantDetailsViewModel: ObservableObject {
    
    @Published var isLoading = true
    @Published var details: RestaurantDetails?
    
    init(id: Int) {
        let urlString = "https://travel.letsbuildthatapp.com/travel_discovery/restaurant?id=\(id)"
        
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                guard let data = data else {
                    return
                }
                do {
                    self.details = try JSONDecoder().decode(RestaurantDetails.self, from: data)
                } catch {
                    print("error")
                }
            }
        }.resume()
    }
    
}

struct RestaurantDetails: Decodable {
    var description, city, country: String
    var popularDishes: [Dish]
    var reviews: [Review]
}

struct Dish: Decodable, Hashable {
    var name, price, photo: String
    var numPhotos: Int
}

struct Review: Decodable, Hashable {
    var user: User
    var rating: Int
    var text: String
}

struct User: Decodable, Hashable {
    var firstName, lastName, profileImage: String
}

struct RestaurantDetailsView: View {
    
    @ObservedObject var vm: RestaurantDetailsViewModel
    let restaurant: Restaurant
    
    init(restaurant: Restaurant) {
        self.restaurant = restaurant
        self.vm = .init(id: restaurant.id)
    }
    
    var body: some View {
        ScrollView {
            ZStack(alignment: .bottomLeading) {
                Image(restaurant.imageName)
                    .resizable()
                    .scaledToFill()
                HStack {
                    VStack(alignment: .leading) {
                        Text(restaurant.name)
                            .font(.system(size: 24, weight: .semibold))
                            .foregroundColor(.white)
                        HStack {
                            ForEach(0..<5) { el in
                                Image(systemName: "star.fill")
                                    .foregroundColor(.yellow)
                            }
                        }
                    }
                    Spacer()
                    NavigationLink {
                        AllPhotosView()
                    } label: {
                        Text("See more photos")
                            .foregroundColor(.white)
                            .font(.system(size: 14, weight: .semibold))
                            .frame(width: 80)
                            .multilineTextAlignment(.trailing)
                    }
                }.padding(.horizontal, 10)
                    .padding(.bottom, 10)
            }
            VStack(alignment: .leading, spacing: 8) {
                Text("Location & Description")
                    .font(.system(size: 16, weight: .bold))
                
                Text("\(vm.details?.city ?? " "), \(vm.details?.country ?? " ")")

                HStack {
                    ForEach(0..<5) { el in
                        Image(systemName: "dollarsign.circle.fill")
                            .foregroundColor(.yellow)
                    }
                }

                Text(vm.details?.description ?? "error")
            }.padding()
            
            HStack {
                Text("Popular Dishes")
                    .font(.system(size: 16, weight: .bold))
                Spacer()
            }.padding(.horizontal)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ForEach(vm.details?.popularDishes ?? [], id: \.self) { dish in
                        DishTile(dish: dish)
                    }
                }.padding(.horizontal)
            }
            if let reviews = vm.details?.reviews {
                ReviewsList(reviews: reviews)
            }
            
        }.navigationTitle("Restaurant details")
            .navigationBarTitleDisplayMode(.inline)
    }
}

struct ReviewsList: View {
    let reviews: [Review]
    
    var body: some View {
        HStack {
            Text("Customer Reviews")
                .font(.system(size: 16, weight: .bold))
            Spacer()
        }.padding(.horizontal)
        
        ForEach(reviews, id: \.self) { review in
            VStack(alignment: .leading) {
                HStack {
                    KFImage(URL(string: review.user.profileImage))
                        .resizable()
                        .scaledToFill()
                        .frame(width: 40, height: 40)
                        .cornerRadius(.infinity)
                    VStack(alignment: .leading) {
                        Text("\(review.user.firstName) \(review.user.lastName)")
                            .font(.system(size: 12))
                        HStack(spacing: 2) {
                            ForEach(0..<review.rating) { _ in
                                Image(systemName: "star.fill")
                                    .foregroundColor(.yellow)
                                    .font(.system(size: 10))
                            }
                            ForEach(0..<5 - review.rating) { _ in
                                Image(systemName: "star.fill")
                                    .foregroundColor(.gray)
                                    .font(.system(size: 10))
                            }
                        }
                    }
                    Spacer()
                    
                }//?????
                Text("\(review.text)")
                    .font(.system(size: 14))
            }.padding(.horizontal)
        }
        
    }
}

struct DishTile: View {
    let dish: Dish
    
    var body: some View {
        VStack(alignment: .leading) {
            ZStack(alignment: .bottomLeading) {
                KFImage(URL(string: dish.photo))
                    .resizable()
                    .scaledToFill()
                LinearGradient(colors: [Color.clear, Color.black], startPoint: .center, endPoint: .bottom)
                Text(dish.price)
                    .font(.system(size: 14, weight: .bold))
                    .foregroundColor(.white)
                    .padding(.horizontal, 4)
                    .padding(.bottom, 4)
            }.frame(height: 100)
                .asTile()
            Text(dish.name)
                .font(.system(size: 10, weight: .bold))
            Text("\(dish.numPhotos) photos")
                .font(.system(size: 8))
                .foregroundColor(.gray)
        }
    }
}

struct RestaurantDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            RestaurantDetailsView(restaurant: .init(name: "japan", imageName: "tapas", id: 0))
        }
    }
}
