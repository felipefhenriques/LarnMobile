//
//  Aula+CoreDataProperties.swift
//  Larn
//
//  Created by Rogerio Lucon on 30/10/20.
//
//

import Foundation
import CoreData


extension Aula {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Aula> {
        return NSFetchRequest<Aula>(entityName: "Aula")
    }

    @NSManaged public var data: Date?
    @NSManaged public var tema: String?
    @NSManaged public var valor: NSDecimalNumber?
    @NSManaged public var requisitos: String?
    @NSManaged public var conteudo: String?
    @NSManaged public var descricao: String?
    @NSManaged public var image: Data?
    @NSManaged public var materia: Materia?

}

extension Aula : Identifiable {

}
