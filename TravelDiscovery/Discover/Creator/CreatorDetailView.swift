//
//  CreatorDetailView.swift
//  TravelDiscovery
//
//  Created by Vasili on 3.03.22.
//

import SwiftUI
import Kingfisher

struct CreatorDetailView: View {
   
    let id: Int
    @ObservedObject var vm: CreatorDetailsViewModel
    
    init(id: Int) {
        self.id = id
        print(id)
        vm = .init(id: id)
    }
    
    var body: some View {
        ScrollView {
            KFImage(URL(string: vm.creator?.profileImage ?? ""))
                .resizable()
                .scaledToFill()
                .frame(width: 60, height: 60)
                .cornerRadius(.infinity)
                .shadow(color: .gray, radius: 10, x: 0, y: 2)
            Text("\(vm.creator?.firstName ?? "oops") \(vm.creator?.lastName ?? "")")
                .font(.system(size: 14, weight: .semibold))
            HStack {
                Text("@\(vm.creator?.username ?? "") •")
                Image(systemName: "hand.thumbsup.fill")
                    .font(.system(size: 10, weight: .semibold))
                Text("2566")
                    
            }.font(.system(size: 14, weight: .semibold))
                .padding(.vertical)
            Text("Youtube, Vlogger, Travel expert")
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(.gray)
                
            HStack(spacing: 12) {
                VStack {
                    Text("\(vm.creator?.followers ?? 228)")
                        .font(.system(size: 13, weight: .semibold))
                    Text("followers")
                        .font(.system(size: 9))
                }
                Spacer()
                    .frame(width:0.5, height: 12)
                    .background(.gray)
                VStack {
                    Text("\(vm.creator?.following ?? 1337)")
                        .font(.system(size: 13, weight: .semibold))
                    Text("following")
                        .font(.system(size: 9))
                }
            }
            HStack(spacing: 12) {
                Button {
                    
                } label: {
                    HStack  {
                        Spacer()
                        Text("Follow")
                            .foregroundColor(.white)
                        Spacer()
                    }
                    .padding(.vertical, 8)
                    .background(.orange)
                    .cornerRadius(.infinity)
                        
                }
                Button {
                    
                } label: {
                    HStack  {
                        Spacer()
                        Text("Contact")
                            .foregroundColor(.black)
                        Spacer()
                    }
                    .padding(.vertical, 8)
                    .background(Color(.lightGray))
                    .cornerRadius(.infinity)
                        
                }
            }.padding(.horizontal)
                .font(.system(size: 14))
            
            ForEach(vm.creator?.posts ?? [], id: \.self) { post in
                VStack(alignment: .leading) {
                    KFImage(URL(string: post.imageUrl))
                        .resizable()
                        .scaledToFill()
                    HStack {
                        KFImage(URL(string: vm.creator?.profileImage ?? ""))
                            .resizable()
                            .scaledToFill()
                            .cornerRadius(.infinity)
                            .frame(width: 40, height: 40)
                        VStack(alignment: .leading) {
                            Text(post.title)
                                .font(.system(size: 14))
                                .frame(height: 10)
                            Text("\(post.views) views")
                                .font(.system(size: 14))
                                .foregroundColor(.gray)
                                .frame(height: 10)

                        }
                    }.padding(.horizontal, 8)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(post.hashtags, id: \.self) { hashtag in
                                Text("# \(hashtag)")
                                    .font(.system(size: 14, weight: .semibold))
                                    .foregroundColor(.blue)
                                    .padding(.horizontal, 12)
                                    .padding(.vertical, 4)
                                    .background(Color(red: 180/255, green: 207/255, blue: 255/255))
                                    .cornerRadius(20)
                            }
                        }.padding(.bottom)
                            .padding(.leading)
                    }
                    
                    
                }
                    .background(.white)
                    .cornerRadius(10)
                    .shadow(color: .init(white: 0.80), radius: 4, x: 0, y: 4)
                
            }.padding()

            
        }.navigationTitle(vm.creator?.firstName ?? "test")
            .navigationBarTitleDisplayMode(.inline)
    }
}

struct CreatorDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CreatorDetailView(id: 0)
    }
}
