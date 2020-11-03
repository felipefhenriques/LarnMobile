//
//  CustomTableViewCell.swift
//  Larn
//
//  Created by Rogerio Lucon on 29/10/20.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var ratingImg: StarRating!
    @IBOutlet weak var sold: UILabel!
    
    var aula: Aula! { didSet {setup(aula: aula)}}
    
    func setup(aula: Aula){
//        self.aula = aula
        
        if let imgData = aula.image {
            img.image = UIImage(data: imgData)
        } else {
            img.image = UIImage(named: "defaultImage")
        }
        
        title.text = aula.tema
        sold.text = aula.valor?.stringValue
    }
}
