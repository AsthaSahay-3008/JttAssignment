//
//  BlogTableViewCellViewModel.swift
//  AsthaBlogSample
//
//  Created by Astha on 23/06/20.
//  Copyright © 2020 Astha Sahay. All rights reserved.
//

import UIKit

fileprivate var dateFormat : DateFormatter { get {
        let dtFormat = DateFormatter()
        dtFormat.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        return dtFormat
    }
}


class BlogTableViewCellViewModel: NSObject {
    
    var blogModel :BlogInfoModel!
    required init(_ model :BlogInfoModel) {
        self.blogModel = model
    }
    
    var displayName             : String { get { let fullName : String = (self.blogModel.userList?.first?.name ?? "")  + " " + (self.blogModel.userList?.first?.lastname ?? "")
        return fullName
        } }
    var displayDesignation      : String { get { return self.blogModel.userList?.first?.designation ?? "" } }
    
    var displayTime             : String { get {
        guard let createdAt = self.blogModel.createdAt, let date = dateFormat.date(from: createdAt) else {
            return ""
        }
            return AppConstraints.timeAgoSinceDate(date, numericDates: true)
        }}
    
    var displayDetails          : String { get { return (self.blogModel.content  ?? "") + "\n\n" + (self.blogModel.mediaList?.first?.title ?? "") } }
    
    var mediaUrl              : URL? { get {
        guard let urlString = self.blogModel.mediaList?.first?.url, let url = URL(string: urlString)
            else { return nil }
        return url
    }}
    
    var displayLikes            : String { get {
        return AppConstraints.formatPoints(Double(self.blogModel.likes ?? 0), place: 2) + " Likes"
    }}
    
    var displayComments         : String { get {
        return AppConstraints.formatPoints(Double(self.blogModel.comments ?? 0), place: 2) + " Comments"
    }}
    
    var profileImageURL         : URL? { get {
        guard let urlString = self.blogModel.userList?.first?.avatar, let url = URL(string: urlString)
            else { return nil }
        return url
    }}
    
    var mediaImageURL           : URL? { get {
        guard let urlString = self.blogModel.mediaList?.first?.image, let url = URL(string: urlString)
            else { return nil }
        return url
    }}
    
    
    
}
