//
//  Team+CoreDataProperties.swift
//  ManifestoManager
//
//  Created by José Fernando Cristóbal Huerta on 30/12/23.
//
//

import Foundation
import CoreData


extension Team {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Team> {
        return NSFetchRequest<Team>(entityName: "Team")
    }

    @NSManaged public var identificador: UUID?
    @NSManaged public var name: String?
    @NSManaged public var temID: UUID?
    @NSManaged public var managers: NSSet?
    @NSManaged public var members: NSSet?
    @NSManaged public var openingHours: NSSet?

}

// MARK: Generated accessors for managers
extension Team {

    @objc(addManagersObject:)
    @NSManaged public func addToManagers(_ value: User)

    @objc(removeManagersObject:)
    @NSManaged public func removeFromManagers(_ value: User)

    @objc(addManagers:)
    @NSManaged public func addToManagers(_ values: NSSet)

    @objc(removeManagers:)
    @NSManaged public func removeFromManagers(_ values: NSSet)

}

// MARK: Generated accessors for members
extension Team {

    @objc(addMembersObject:)
    @NSManaged public func addToMembers(_ value: User)

    @objc(removeMembersObject:)
    @NSManaged public func removeFromMembers(_ value: User)

    @objc(addMembers:)
    @NSManaged public func addToMembers(_ values: NSSet)

    @objc(removeMembers:)
    @NSManaged public func removeFromMembers(_ values: NSSet)

}

// MARK: Generated accessors for openingHours
extension Team {

    @objc(addOpeningHoursObject:)
    @NSManaged public func addToOpeningHours(_ value: Availability)

    @objc(removeOpeningHoursObject:)
    @NSManaged public func removeFromOpeningHours(_ value: Availability)

    @objc(addOpeningHours:)
    @NSManaged public func addToOpeningHours(_ values: NSSet)

    @objc(removeOpeningHours:)
    @NSManaged public func removeFromOpeningHours(_ values: NSSet)

}

extension Team : Identifiable {

}
