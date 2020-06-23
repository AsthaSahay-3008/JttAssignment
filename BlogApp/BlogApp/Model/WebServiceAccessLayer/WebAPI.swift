//
//  WebAPI.swift
//  AsthaBlogSample
//
//  Created by Astha on 23/06/20.
//  Copyright © 2020 Astha Sahay. All rights reserved.
//

import UIKit

private enum BlogInfoAPI :String {
    case blogInfo = "https://5e99a9b1bc561b0016af3540.mockapi.io/jet2/api/v1/blogs?"
}


enum BlogInfoResponse {
    case blogData([BlogInfoModel])
    case failedWithError( error:Error)
    case failedWithMessage(message:String)
}

class WebAPI: NSObject {
    
    /// Parse Blog data
    ///
    /// - Parameters:
    ///  - limit: no of data to receive
    ///  - page: page to load
    ///  - completionHandler: Callback clousere for passing information.

    class func getBlogInfo(_ page: Int , limit: Int , completionHandler:@escaping(BlogInfoResponse)->Void) {
        WebServiceWrapper.callHTTPGetService(BlogInfoAPI.blogInfo.rawValue, param: ["page" : page, "limit" : limit]) { response in
            switch response {
                case .success(data: let data):
                    completionHandler(.blogData(parseBlogData(data:data)))
                case .failedWithError(error: let error):
                    completionHandler(.failedWithError(error: error))
                case .failedWithMessage(message: let message):
                    completionHandler(.failedWithMessage(message: message))
            }
        }
    }
    
    /// Parse Blog data
    ///
    /// - Parameter data: Raw data which received from cloud
    /// - Returns: return BlogInformation
    class func parseBlogData(data:Data) -> [BlogInfoModel] {
        if let validJsonString = String(data: data, encoding: .isoLatin1), let convertData = (validJsonString.data(using: .utf8)) {
            return parseBlogJsonString(jsonData:convertData)
        }
        return []
    }
    
    /// Parse Blog JSON STring
    ///
    /// - Parameter data: Raw data which received from cloud
    /// - Returns: return BlogInformation
    class func parseBlogJsonString(jsonData:Data) -> [BlogInfoModel] {
        var blogArray    = [BlogInfoModel]()
        do {
            let decoder  = try JSONDecoder().decode([BlogInfoModel].self, from: jsonData)
            blogArray.append(contentsOf: decoder)
        } catch {
            print("Error deserializing JSON: \(error)")
        }
        return blogArray
    }
}
