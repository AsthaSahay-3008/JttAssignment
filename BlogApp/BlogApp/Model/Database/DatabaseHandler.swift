//
//  DatabaseHandler.swift
//  BlogApp
//
//  Created by Astha on 23/06/20.
//  Copyright © 2020 Astha. All rights reserved.
//

import UIKit
import CoreData


class DatabaseHandler: NSObject {
    
    let appDelegate = UIApplication.shared.delegate as? AppDelegate
    /// Save Data to database when online
    ///
    /// - Parameters:
    ///  -jsonToSave: save Json
    
    func saveDataToDataBase(jsonToSave:String, page:Int) {
        
        
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        if !getData(for: page).isEmpty {
            deleteData(for: page)
        }
        let entity = NSEntityDescription.entity(forEntityName: "OfflineBlogData", in: managedContext)!
        let offlineBlogData = NSManagedObject(entity: entity, insertInto: managedContext)
        offlineBlogData.setValue(jsonToSave, forKeyPath:"jsonData")
        offlineBlogData.setValue(Date(), forKeyPath:"lastUpdated")
        offlineBlogData.setValue(page, forKeyPath:"page")
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    /// Save Data to database when online
    ///
    /// - Returns:  last saved blog list
    func getData(for page:Int) -> [BlogInfoModel] {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return []}
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "OfflineBlogData")
        fetchRequest.predicate = NSPredicate(format: "page == %@", page)

        do {
            let offlineData = try managedContext.fetch(fetchRequest)
            for data in offlineData {
                let jsonString = data.value(forKey:"jsonData") as? String ?? ""
                let convertData = jsonString.data(using: .utf8) ?? Data()
                return WebAPI.parseBlogJsonString(jsonData:convertData)

            }
            
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        return []
    }
    
    /// Delete Old Data from database
    ///
    func deleteData(for page: Int) {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "OfflineBlogData")
        fetchRequest.predicate = NSPredicate(format: "page == %@", page)
        do {
            let offlineData = try managedContext.fetch(fetchRequest)
            for data in offlineData {
                managedContext.delete(data)
                do {
                    try managedContext.save()
                } catch let error as NSError {
                    print("Could not delete. \(error), \(error.userInfo)")
                }
            }
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }

    }
    
}

