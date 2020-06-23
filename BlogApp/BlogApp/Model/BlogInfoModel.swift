//
//  BlogInfoModel.swift
//  AsthaBlogSample
//
//  Created by Astha on 23/06/20.
//  Copyright © 2020 Astha Sahay. All rights reserved.
//

import UIKit

struct BlogInfoModel: Codable {
    
    let blogId      : String?
    let createdAt   : String?
    let content     : String?
    let comments    : Int?
    let likes       : Int?
    var keyMedia    : String?
    var keyUser     : String?
    let mediaList   : [MediaInfoModel]?
    let userList    : [UserInfoModel]?
    
    private enum CodingKeys: String, CodingKey {
        case blogId         = "id"
        case createdAt      = "createdAt"
        case content        = "content"
        case comments       = "comments"
        case likes          = "likes"
        case keyMedia       = "media"
        case keyUser        = "user"
    }
    
    init(from decoder: Decoder) throws {
        let container   = try decoder.container(keyedBy: CodingKeys.self)
        blogId          = try container.decode(String.self, forKey: .blogId)
        createdAt       = try container.decode(String.self, forKey: .createdAt)
        content         = try container.decode(String.self, forKey: .content)
        comments        = try container.decode(Int.self, forKey: .comments)
        likes           = try container.decode(Int.self, forKey: .likes)
        mediaList       = try container.decode([MediaInfoModel].self, forKey: .keyMedia)
        userList        = try container.decode([UserInfoModel].self, forKey: .keyUser)
    }

}
