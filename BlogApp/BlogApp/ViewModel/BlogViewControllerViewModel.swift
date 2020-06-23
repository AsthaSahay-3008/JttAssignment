//
//  BlogViewControllerViewModel.swift
//  AsthaBlogSample
//
//  Created by Astha on 23/06/20.
//  Copyright © 2020 Astha Sahay. All rights reserved.
//

import UIKit
import CoreData

protocol BlogViewControllerViewModelDelegate : NSObjectProtocol {
   func showAlaert(_ message: String?)
   func reloadBlogData()
}

extension BlogViewControllerViewModelDelegate {
    func showAlaert(_ message: String?) {}
    func reloadBlogData() {}
}

class BlogViewControllerViewModel: NSObject {
    
    lazy var currentIndex = 0
    lazy var isMaxReach = false
    lazy var blogList = [BlogInfoModel]()
    weak var callBack :BlogViewControllerViewModelDelegate?
    
    required init(_ viewDelegate :BlogViewControllerViewModelDelegate?) {
        super.init()
        self.callBack = viewDelegate
    }
    
 func loadMoreData() {
    if !isMaxReach {
     currentIndex = currentIndex + 1
     WebAPI.getBlogInfo(currentIndex, limit: 10) {[unowned self] blogRespose in
        switch blogRespose {
        case .blogData(let blogData):
            if blogData.count > 0 {
                self.blogList.append(contentsOf: blogData)
                self.callBack?.reloadBlogData()
            } else {
                self.isMaxReach = true
            }
        case .failedWithError(error: let error):
            self.callBack?.showAlaert(error.localizedDescription)
        case .failedWithMessage(message: let errorMessage):
            self.callBack?.showAlaert(errorMessage)
        }
     }
    }
 }
 
 func numberOfRow() -> Int {
         return blogList.count
 }
 func objectForIndex(index:IndexPath) -> BlogInfoModel {
     return blogList[index.row]
 }
    
 func blogForCell(index:IndexPath) -> BlogInfoModel {
    return blogList[index.row]
 }
    func fethDataFromDatabase()  {
      
    }
 
 }
