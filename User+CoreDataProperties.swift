//
//  User+CoreDataProperties.swift
//  ResortFeedback-IOS
//
//  Created by Maricel Sumulong on 3/6/22.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var password: String?
    @NSManaged public var username: String?

}

extension User : Identifiable {

}
