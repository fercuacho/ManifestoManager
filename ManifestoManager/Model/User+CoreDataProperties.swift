//
//  User+CoreDataProperties.swift
//  ManifestoManager
//
//  Created by José Fernando Cristóbal Huerta on 01/01/24.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var availability: String?
    @NSManaged public var color: Int64
    @NSManaged public var email: String?
    @NSManaged public var identificador: UUID?
    @NSManaged public var lastname: String?
    @NSManaged public var maxHoursToWork: Int64
    @NSManaged public var name: String?
    @NSManaged public var numero: String?
    @NSManaged public var password: String?
    @NSManaged public var position: Int64
    @NSManaged public var ratePerHour: Int64
    @NSManaged public var tipoUsuario: String?
    @NSManaged public var managerTeam: NSSet?
    @NSManaged public var team: Team?

}

// MARK: Generated accessors for managerTeam
extension User {

    @objc(addManagerTeamObject:)
    @NSManaged public func addToManagerTeam(_ value: Team)

    @objc(removeManagerTeamObject:)
    @NSManaged public func removeFromManagerTeam(_ value: Team)

    @objc(addManagerTeam:)
    @NSManaged public func addToManagerTeam(_ values: NSSet)

    @objc(removeManagerTeam:)
    @NSManaged public func removeFromManagerTeam(_ values: NSSet)

}

extension User : Identifiable {

}
