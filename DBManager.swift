//
//  DBManager.swift
//  ResortFeedback-IOS
//
//  Created by Maricel Sumulong on 3/5/22.
//

import Foundation
import UIKit
import CoreData

class DBManager {
    
    let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    
    static var inst = DBManager()
    
    func addData(u: String, p: String) -> Bool {
        
        let user = NSEntityDescription.insertNewObject(forEntityName: "User", into: context!) as! User
        
        user.username = u
        user.password = p
        
        do {
            
            try context?.save()
            return true
            
        } catch {
            
            return false
        
        }
        
    }
    
    func login (u: String, p: String) -> [User] {
        
        var user = [User]()
        let fReq = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        
        let namePredicate = NSPredicate(format: "username==%@", u)
        let passPredicate = NSPredicate(format: "password==%@", p)
        
        fReq.predicate = NSCompoundPredicate(
            andPredicateWithSubpredicates: [
                namePredicate,
                passPredicate
            ]
        )
        
        do {
            
            user = try context?.fetch(fReq) as! [User]
       
        } catch {
        
            print("Can't fetch any data!")
          
          }
        
        return user
        
        
    }
    
    func checkUserAvailability(u: String) -> Bool {
        
        print("error")
        
        //var st = User()
        print("error2")
        let fReq = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        fReq.predicate = NSPredicate(format: "username==%@", u)
        fReq.fetchLimit = 1
        
        do {
            let req = try context?.fetch(fReq) as! [User]
            if (req.count != 0) {
                //st = req.first as! User
                //print("username exists")
                return false
            } else {
                //print("username does not exist")
                return true
              }
        } catch {
            //print("Can't fetch any data!")
            return false
          }
        
    }
    
    func addUserFoodTally(u: String, t: String) -> Bool {
        
        let userFoodTally = NSEntityDescription.insertNewObject(forEntityName: "FoodSurvey", into: context!) as! FoodSurvey
        
        userFoodTally.username = u
        userFoodTally.tallyscore = t

        
        do {
            
            try context?.save()
            return true
            
        } catch {
            
            return false
        
          }
        
    }
}
