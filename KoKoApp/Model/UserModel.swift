//
//  UserModel.swift
//  KoKoApp
//
//  Created by 陳韋綸 on 2023/10/18.
//

import Foundation

struct UserResponse: Decodable {
    var response: [UserModel]?
}

struct UserModel: Decodable {
    var name: String?
    var kokoid: String?
}
