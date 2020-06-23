//
//  MediaInfoModel.swift
//  AsthaBlogSample
//
//  Created by Astha on 23/06/20.
//  Copyright © 2020 Astha Sahay. All rights reserved.
//

import UIKit

struct MediaInfoModel: Codable {
    private enum CodingKeys: String, CodingKey {
        case mediaId        = "id"
        case blogId         = "blogId"
        case createdAt      = "createdAt"
        case image          = "image"
        case title          = "title"
        case url            = "url"

    }
    
    let mediaId     : String?
    let blogId      : String?
    let createdAt   : String?
    let image       : String?
    let title       : String?
    let url         : String?
    
    init(from decoder: Decoder) throws {
        let container   = try decoder.container(keyedBy: CodingKeys.self)
        
        mediaId         = try container.decode(String.self, forKey: .mediaId)
        blogId          = try container.decode(String.self, forKey: .blogId)
        createdAt       = try container.decode(String.self, forKey: .createdAt)
        image           = try container.decode(String.self, forKey: .image)
        title           = try container.decode(String.self, forKey: .title)
        url             = try container.decode(String.self, forKey: .url)
    }
}
