//
//  CreatorDetails.swift
//  TravelDiscovery
//
//  Created by Vasili on 3.03.22.
//

import Foundation

struct CreatorDetails: Decodable, Hashable {
    var username, firstName, lastName, profileImage: String
    var followers, following: Int
    var posts: [Post]
}

struct Post: Decodable, Hashable {
    var title, imageUrl, views: String
    var hashtags: [String]
}
