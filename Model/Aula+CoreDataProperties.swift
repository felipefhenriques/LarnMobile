//
//  Aula+CoreDataProperties.swift
//  Larn
//
//  Created by Rogerio Lucon on 10/11/20.
//
//

import Foundation
import CoreData
import UIKit

extension Aula {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Aula> {
        return NSFetchRequest<Aula>(entityName: "Aula")
    }

    @NSManaged public var conteudo: String?
    @NSManaged public var data: Date?
    @NSManaged public var descricao: String?
    @NSManaged public var id: UUID?
    @NSManaged public var image: Data?
    @NSManaged public var requisitos: String?
    @NSManaged public var tema: String?
    @NSManaged public var valor: NSDecimalNumber?
    @NSManaged public var materia: Materia?

}

extension Aula : Identifiable {

    func dataToImage() -> UIImage? {
            guard let data = image else {
                return nil
            }
            return UIImage(data: data)
        }
}
