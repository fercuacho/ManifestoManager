//
//  User+CoreDataProperties.swift
//  ManifestoManager
//
//  Created by José Fernando Cristóbal Huerta on 30/12/23.
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
    @NSManaged public var managerTeam: Team?
    @NSManaged public var team: Team?

}

extension User : Identifiable {

}
