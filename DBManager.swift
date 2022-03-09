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
        user.scores = ""
        user.feedback = ""
        
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
    
    func checkUserAvailability(u: String) -> Int {
        
        
        //var st = User()
        let fReq = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        fReq.predicate = NSPredicate(format: "username==%@", u)
        fReq.fetchLimit = 1
        
        do {
            let req = try context?.fetch(fReq) as! [User]
            if (req.count != 0) {
                //st = req.first as! User
                //print("username exists")
                return 1
            } else {
                //print("username does not exist")
                return 0
              }
        } catch {
            //print("Can't fetch any data!")
            return 2
          }
        
    }
    
    func addUserFoodTally(u: String, t: String) -> Bool {
        
        var st = User()
        let fReq = NSFetchRequest<NSManagedObject>.init(entityName: "User")
        fReq.predicate = NSPredicate(format: " username == %@ ", u)
        
        do {
            let stu = try context?.fetch(fReq)
            if (stu?.count != 0) {
                st = stu?.first as! User
                st.scores = t
                //st.feedback = ""
                
                try context?.save()
                //printData()
                //print("Data Updated")
                return true
            }
            
        } catch {
            
            print("Data Not Updated!")
            return false
          
        }
        
        return false
        
    }
    
    func deleteData() -> Bool {
        
        let fReq: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "User")
        fReq.predicate = NSPredicate(format: "username!='admin'")
        //let bobPredicate = NSPredicate(format: "firstName = 'Bob'")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fReq)

        do {
            try context?.execute(deleteRequest)
            try context?.save()
            //printData()
            return true
            //try myPersistentStoreCoordinator.execute(deleteRequest, with: myContext)
        } catch let error as NSError {
            print(error)
            return false
        }
        
    }
    
    func getData() -> [User] {
        
        var stu = [User]()
        let fReq = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        
        do {
            stu = try context?.fetch(fReq) as! [User]
        } catch {
                print("Can't fetch any data!")
          }
        
        return stu
        
    }
    
    func addUserOverallFeedback(u: String, f: String) -> Bool {
        
        var st = User()
        let fReq = NSFetchRequest<NSManagedObject>.init(entityName: "User")
        fReq.predicate = NSPredicate(format: " username == %@ ", u)
        
        do {
            let stu = try context?.fetch(fReq)
            if (stu?.count != 0) {
                st = stu?.first as! User
                st.feedback = f
                
                try context?.save()
                //printData()
                //print("Data Updated")
                return true
            }
            
        } catch {
            
            print("Data Not Updated!")
            return false
          
        }
        
        return false
        
    }
    
    func printData() {
        
        let us = getData()
        for j in 0...us.count-1{
            print("USER \(j): \(us[j].username!)")
            print("USER \(j): \(us[j].password!)")
            print("USER \(j): \(us[j].scores!)")
            print("USER \(j): \(us[j].feedback!)")
        }
        
    }
    
}
