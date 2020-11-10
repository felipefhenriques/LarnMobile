//
//  SelfConfiguringCell.swift
//  Larn
//
//  Created by Rogerio Lucon on 08/11/20.
//

import Foundation

protocol SelfConfiguringCell {
    static var reuseIdentifier: String { get }
    func configure(with aula: App)
}
