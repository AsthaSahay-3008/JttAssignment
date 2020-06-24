//
//  ConnectionManager.swift
//  BlogApp
//
//  Created by Astha on 24/06/20.
//  Copyright © 2020 Astha. All rights reserved.
//

import UIKit
import Reachability

class ConnectionManager: NSObject {
    var reachability: Reachability!
    static let sharedInstance: ConnectionManager = {
        return ConnectionManager()
        
    }()
    override init() {
        super.init()
        do {
            reachability = try Reachability()
                NotificationCenter.default.addObserver(            self,            selector: #selector(networkStatusChanged(_:)),            name: .reachabilityChanged,            object: reachability        )
            do {
                try reachability.startNotifier()
                
            } catch {
                print("Unable to start notifier")
                
                }
        } catch {
            
        }
        
    }
    @objc func networkStatusChanged(_ notification: Notification) {
        
    }
       static func stopNotifier() -> Void {
        do {
            try (ConnectionManager.sharedInstance.reachability).startNotifier()
            
        } catch {
            print("Error stopping notifier")
            
        }
        
    }
    
    static func isReachable(completed: @escaping (ConnectionManager) -> Void) {
        if (ConnectionManager.sharedInstance.reachability).connection != .unavailable {            completed(ConnectionManager.sharedInstance)
        
        }
        
    }
    static func isUnreachable(completed: @escaping (ConnectionManager) -> Void) {
        if (ConnectionManager.sharedInstance.reachability).connection == .unavailable {            completed(ConnectionManager.sharedInstance)
        
        }
        
    }
    
    static func isReachableViaWiFi(completed: @escaping (ConnectionManager) -> Void) {
        if (ConnectionManager.sharedInstance.reachability).connection == .wifi {            completed(ConnectionManager.sharedInstance)
            
        }
        
    }


}
