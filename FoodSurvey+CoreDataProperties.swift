//
//  FoodSurvey+CoreDataProperties.swift
//  ResortFeedback-IOS
//
//  Created by Maricel Sumulong on 3/6/22.
//
//

import Foundation
import CoreData


extension FoodSurvey {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FoodSurvey> {
        return NSFetchRequest<FoodSurvey>(entityName: "FoodSurvey")
    }

    @NSManaged public var username: String?
    @NSManaged public var tallyscore: String?

}

extension FoodSurvey : Identifiable {

}
