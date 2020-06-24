//
//  UserInfo+CoreDataProperties.swift
//  BlogApp
//
//  Created by Astha on 23/06/20.
//  Copyright © 2020 Astha. All rights reserved.
//
//

import Foundation
import CoreData


extension UserInfo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserInfo> {
        return NSFetchRequest<UserInfo>(entityName: "UserInfo")
    }

    @NSManaged public var about: String?
    @NSManaged public var avatar: String?
    @NSManaged public var blogId: String?
    @NSManaged public var city: String?
    @NSManaged public var createdAt: String?
    @NSManaged public var designation: String?
    @NSManaged public var lastname: String?
    @NSManaged public var name: String?
    @NSManaged public var userId: String?
    @NSManaged public var newRelationship: BlogInfo?

}
