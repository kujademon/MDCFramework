//
//  FBModel.swift
//  busProject
//
//  Created by Pitchaorn on 16/8/2562 BE.
//  Copyright © 2562 Freewillsolutions. All rights reserved.
//

import Foundation

// MARK: - FacebookModel
struct FacebookModel: Codable {
    let email, firstName: String?
    let id: String?
    let lastName, name: String?
    let picture: Picture?
    
    enum CodingKeys: String, CodingKey {
        case email
        case firstName = "first_name"
        case id
        case lastName = "last_name"
        case name, picture
    }
}

// MARK: - Picture
struct Picture: Codable {
    let data: DataClass?
}

// MARK: - DataClass
struct DataClass: Codable {
    let height : Int?
    let isSilhouette: Bool?
    let url: String?
    let width: Int?
    
    enum CodingKeys: String, CodingKey {
        case height
        case isSilhouette = "is_silhouette"
        case url, width
    }
}
