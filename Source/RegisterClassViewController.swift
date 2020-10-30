//
//  RegisterClassViewController.swift
//  Larn
//
//  Created by Rogerio Lucon on 30/10/20.
//

import UIKit

class RegisterClassViewConroller: UIViewController {
    
    let contex = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var tema: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var learn: UITextView!
    @IBOutlet weak var des: UITextView!
    @IBOutlet weak var req: UITextView!
    @IBOutlet weak var price: UITextField!
    
    override func viewDidLoad() {
        if #available(iOS 13.4, *) {
                datePicker.preferredDatePickerStyle = .compact
        }
        let tap = UITapGestureRecognizer(target: self, action: #selector (changeImage))
        image.isUserInteractionEnabled = true
        image.addGestureRecognizer(tap)
    }
    
    
    @objc func changeImage(){
        print("Change Image")
    }
    
    @IBAction func publish(_ sender: Any) {
        let aula = Aula(context: self.contex)
        aula.tema = tema.text
        aula.requisitos = req.text
        aula.conteudo = learn.text
        aula.descricao = des.text
        aula.data = datePicker.date
        aula.valor = NSDecimalNumber(string: price.text)
        do {
            try contex.save()
        } catch {
            
        }
    }
}
