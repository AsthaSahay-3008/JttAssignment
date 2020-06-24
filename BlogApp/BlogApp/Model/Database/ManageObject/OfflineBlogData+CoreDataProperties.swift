//
//  OfflineBlogData+CoreDataProperties.swift
//  BlogApp
//
//  Created by Astha on 24/06/20.
//  Copyright © 2020 Astha. All rights reserved.
//
//

import Foundation
import CoreData


extension OfflineBlogData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<OfflineBlogData> {
        return NSFetchRequest<OfflineBlogData>(entityName: "OfflineBlogData")
    }

    @NSManaged public var jsonData: String?
    @NSManaged public var lastUpdated: Date?
    @NSManaged public var page: Int64

}
