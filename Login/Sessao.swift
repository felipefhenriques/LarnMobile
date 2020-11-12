//
//  Sessao.swift
//  Larn
//
//  Created by Rogerio Lucon on 12/11/20.
//

import Foundation
import CoreData

class Sessao {
    
    static let shared = Sessao()
    private var user: NSManagedObject?
    
    private init(){}
    
    func saveUsuario(user: NSManagedObject) {
        self.user = user
    }

    func loadUsuario() -> NSManagedObject {
        guard let user = self.user else {
            fatalError("Não há sessao vinculada")
        }
        return user
    }
    
}
