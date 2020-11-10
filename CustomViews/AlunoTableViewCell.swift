//
//  AlunoTableViewCell.swift
//  Larn
//
//  Created by Rogerio Lucon on 10/11/20.
//

import UIKit

class AlunoTableViewCell:  UITableViewCell {
    
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var category: UILabel!
    @IBOutlet weak var link: UIButton!
    
    
    var aula: Aula! { didSet {setup(aula: aula)}}
    
    func setup(aula: Aula){
//        self.aula = aula
        
        if let imgData = aula.image {
            img.image = UIImage(data: imgData)
        } else {
            img.image = UIImage(named: "defaultImage")
        }
        
        title.text = aula.tema
    }
    
    @IBAction func linkClick(_ sender: Any) {
        
    }
}
