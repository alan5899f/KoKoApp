//
//  FriendModel.swift
//  KoKoApp
//
//  Created by 陳韋綸 on 2023/10/18.
//

import Foundation

struct FriendsResponse: Decodable, Equatable {
    var response: [FriendModel]?
}

struct FriendModel: Decodable, Equatable {
    var name: String?
    var status: Int?
    var isTop: String?
    var fid: String?
    var updateDate: String?
}
