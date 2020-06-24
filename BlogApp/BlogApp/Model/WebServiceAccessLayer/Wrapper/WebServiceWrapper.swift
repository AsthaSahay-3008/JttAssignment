//
//  WebServiceWrapper.swift
//  AsthaBlogSample
//
//  Created by Astha on 23/06/20.
//  Copyright © 2020 Astha Sahay. All rights reserved.
//

import UIKit

public enum WebServiceResponse {
    case success(data:Data)
    case failedWithError(error:Error)
    case failedWithMessage(message:String)
}

class WebServiceWrapper: NSObject {
    static let shared = WebServiceWrapper()
   
    lazy var  urlSession = URLSession(configuration: .default, delegate: WebServiceWrapper.shared, delegateQueue: .current)
    
    /// Default get method for web service call
    ///
    /// - Parameters:
    ///   - urlPath: url path
    ///   - param: Webservice parameter
    ///   - completionHandler: Callback clousere for passing messag.
    class func callHTTPGetService(_ urlPath:String, param:[String: Any]?, completionHandler:((WebServiceResponse)->Void)?)  {
        var urlGetPath = urlPath
        if let param = param {
            urlGetPath.append(param.map {  $0 + "=" + "\($1)" }.joined(separator: "&"))
        }
        guard let url = URL(string: urlGetPath) else
        {
            completionHandler?(.failedWithMessage(message: "Invalid URL"))
            return
        }
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringCacheData, timeoutInterval: 30)
        let dataTask = WebServiceWrapper.shared.urlSession.dataTask(with: request) { (data, urlResponse, error) in
            
            if let data = data, let response = urlResponse as? HTTPURLResponse , response.statusCode == 200 {
                completionHandler?(.success(data: data))
            } else if let error = error {
                completionHandler?(.failedWithError(error: error))
            } else {
                completionHandler?(.failedWithMessage(message: "Unable to get data, Unknown error."))
            }
        }
        dataTask.resume()
    }
        
    /// Download Image Class
    ///
    /// - Parameters:
    ///   - urlPath: Image web service path
    ///   - completionHandler: Callback clousere for passing messag.
    class func downloadImage(_ urlPath:String, completionHandler:((WebServiceResponse)->Void)?)  {
        callHTTPGetService(urlPath, param: nil, completionHandler: completionHandler)
    }
        
    }

extension WebServiceWrapper:  URLSessionDelegate {
    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        if let serverTrust = challenge.protectionSpace.serverTrust {
             completionHandler(.useCredential, URLCredential(trust: serverTrust))
        } else {
            completionHandler(.useCredential, nil)
        }
    }
}
