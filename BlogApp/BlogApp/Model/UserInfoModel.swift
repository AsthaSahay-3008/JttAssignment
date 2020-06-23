//
//  UserInfoModel.swift
//  AsthaBlogSample
//
//  Created by Astha on 23/06/20.
//  Copyright © 2020 Astha Sahay. All rights reserved.
//

import UIKit

struct UserInfoModel: Codable {
    let userId      : String?
    let blogId      : String?
    let createdAt   : String?
    let name        : String?
    let avatar      : String?
    let lastname    : String?
    let city        : String?
    let designation : String?
    let about       : String?
    
    private enum CodingKeys: String, CodingKey {
        case userId         = "id"
        case blogId         = "blogId"
        case createdAt      = "createdAt"
        case name           = "name"
        case avatar         = "avatar"
        case lastname       = "lastname"
        case city           = "city"
        case designation    = "designation"
        case about          = "about"

    }
    init(from decoder: Decoder) throws {
        let container   = try decoder.container(keyedBy: CodingKeys.self)
        
        userId          = try container.decode(String.self, forKey: .userId)
        blogId          = try container.decode(String.self, forKey: .blogId)
        createdAt       = try container.decode(String.self, forKey: .createdAt)
        name            = try container.decode(String.self, forKey: .name)
        avatar          = try container.decode(String.self, forKey: .avatar)
        lastname        = try container.decode(String.self, forKey: .lastname)
        city            = try container.decode(String.self, forKey: .city)
        designation     = try container.decode(String.self, forKey: .designation)
        about           = try container.decode(String.self, forKey: .about)
    }

}

