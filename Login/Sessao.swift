//
//  Sessao.swift
//  Larn
//
//  Created by Rogerio Lucon on 12/11/20.
//

import Foundation
import CoreData

extension UserDefaults {
    
    private static let sessaoKey = "sessao"
    
    func saveUsuario(user: NSManagedObject) {
        set(user, forKey: UserDefaults.sessaoKey)
//        print("Salvando usuario \(user)")
    }
    
    func loadUsuario() -> NSManagedObject {
        guard let user: NSManagedObject = object(forKey: UserDefaults.sessaoKey) as? NSManagedObject else {
            fatalError("LoadUsuario falhou!")
        }
        return user
    }
}
