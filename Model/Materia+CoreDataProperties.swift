//
//  Materia+CoreDataProperties.swift
//  Larn
//
//  Created by Rogerio Lucon on 10/11/20.
//
//

import Foundation
import CoreData


extension Materia {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Materia> {
        return NSFetchRequest<Materia>(entityName: "Materia")
    }

    @NSManaged public var materia: String?

}

extension Materia : Identifiable {

}
