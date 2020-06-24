//
//  BlogInfo+CoreDataProperties.swift
//  BlogApp
//
//  Created by Astha on 23/06/20.
//  Copyright © 2020 Astha. All rights reserved.
//
//

import Foundation
import CoreData


extension BlogInfo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<BlogInfo> {
        return NSFetchRequest<BlogInfo>(entityName: "BlogInfo")
    }

    @NSManaged public var blogid: String?
    @NSManaged public var comments: Int64
    @NSManaged public var content: String?
    @NSManaged public var createdAt: String?
    @NSManaged public var likes: Int64
    @NSManaged public var newRelationship: UserInfo?
    @NSManaged public var newRelationship1: MediaInfo?

}

// MARK: Generated accessors for newRelationship
extension BlogInfo {

    @objc(addNewRelationshipObject:)
    @NSManaged public func addToNewRelationship(_ value: UserInfo)

    @objc(removeNewRelationshipObject:)
    @NSManaged public func removeFromNewRelationship(_ value: UserInfo)

    @objc(addNewRelationship:)
    @NSManaged public func addToNewRelationship(_ values: NSSet)

    @objc(removeNewRelationship:)
    @NSManaged public func removeFromNewRelationship(_ values: NSSet)

}

// MARK: Generated accessors for newRelationship1
extension BlogInfo {

    @objc(addNewRelationship1Object:)
    @NSManaged public func addToNewRelationship1(_ value: MediaInfo)

    @objc(removeNewRelationship1Object:)
    @NSManaged public func removeFromNewRelationship1(_ value: MediaInfo)

    @objc(addNewRelationship1:)
    @NSManaged public func addToNewRelationship1(_ values: NSSet)

    @objc(removeNewRelationship1:)
    @NSManaged public func removeFromNewRelationship1(_ values: NSSet)

}
