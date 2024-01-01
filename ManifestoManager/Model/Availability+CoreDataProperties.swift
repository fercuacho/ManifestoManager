//
//  Availability+CoreDataProperties.swift
//  ManifestoManager
//
//  Created by José Fernando Cristóbal Huerta on 30/12/23.
//
//

import Foundation
import CoreData


extension Availability {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Availability> {
        return NSFetchRequest<Availability>(entityName: "Availability")
    }

    @NSManaged public var dayOfWeek: String?
    @NSManaged public var minMembers: Int64
    @NSManaged public var openingHour: String?
    @NSManaged public var shiftLength: Double
    @NSManaged public var availability: Team?

}

extension Availability : Identifiable {

}
