//
//  MediaInfo+CoreDataProperties.swift
//  BlogApp
//
//  Created by Astha on 23/06/20.
//  Copyright © 2020 Astha. All rights reserved.
//
//

import Foundation
import CoreData


extension MediaInfo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MediaInfo> {
        return NSFetchRequest<MediaInfo>(entityName: "MediaInfo")
    }

    @NSManaged public var blogId: String?
    @NSManaged public var createdAt: String?
    @NSManaged public var image: String?
    @NSManaged public var mediaId: Int64
    @NSManaged public var title: String?
    @NSManaged public var url: String?
    @NSManaged public var newRelationship: BlogInfo?

}
