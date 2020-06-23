//
//  ImageDownloader.swift
//  AsthaBlogSample
//
//  Created by Astha on 23/06/20.
//  Copyright © 2020 Astha Sahay. All rights reserved.
//

import UIKit

/// Save image Library
class ImageDownloader: NSObject {
    
    
    /// Download Image from cloud.
    ///
    /// - Parameters:
    ///   - path: image URL
    ///   - completionHandler: Callback clousere for passing messag.
    class func downloadImage(path:String, completionHandler:((WebServiceResponse)->Void)?) {
        WebServiceWrapper.downloadImage(path, completionHandler: completionHandler)
    }
    
    
    /// Store image in cache directory
    ///
    /// - Parameters:
    ///   - path: image Path
    ///   - data: which data store in Cache directory
    /// - Returns: Callback clousere for passing messag.
    @discardableResult class func storeInCache(path:String, data:Data) -> Bool {
        let cachePath = NSString(string:NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first!)
        let filePath = cachePath.appendingPathComponent(NSString(string: path).lastPathComponent)
       return FileManager.default.createFile(atPath: filePath, contents: data, attributes: nil)
    }
    
    /// FetchImage from Cache directory
    ///
    /// - Parameter path: image path
    /// - Returns: Callback clousere for passing messag.
    @discardableResult class func fetchFromCache(path:String) -> Data?  {
        let cachePath = NSString(string:NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first!)
        let filePath = cachePath.appendingPathComponent(path)
        if FileManager.default.fileExists(atPath: filePath) {
           return try? Data(contentsOf: URL(fileURLWithPath: filePath))
        }
        return nil
    }
    
    /// Show Image From Cache
    ///
    /// - Parameters:
    ///  - urlPath: image path
    ///  - completionHandler: Callback clousere for passing information.
    /// - Returns: UIImage: return image from the cache
    @discardableResult class func showImageFromCache(_ urlPath: URL, completionHandler:@escaping(UIImage?)->Void) -> UIImage? {
        let path = urlPath.absoluteString
        var fileName = urlPath.absoluteString
        if let host = urlPath.host, let name = fileName.components(separatedBy: host).last {
            fileName = name
        }
        fileName = fileName.replacingOccurrences(of: "/", with: "_").replacingOccurrences(of: "?", with: "")
        if let data = ImageDownloader.fetchFromCache(path: fileName) {
            let image = UIImage(data: data)
            completionHandler(image)
            return image
        }
        else if path.count > 0 {
            ImageDownloader.downloadImage(path: path) { response in
                switch response {
                    case .success(data: let data):
                        ImageDownloader.storeInCache(path: fileName, data: data)
                        completionHandler(UIImage(data: data))
                    default:
                        completionHandler(nil)
                }
            }
        } else {
            completionHandler(nil)
        }
        return nil
    }
    
}
