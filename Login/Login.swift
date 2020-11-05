//
//  Login.swift
//  Larn
//
//  Created by Felipe Ferreira on 04/11/20.
//

import Foundation
import UIKit
import CoreData

class Login: UIViewController, UITextFieldDelegate {
    
    var user:[NSManagedObject] = []
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtSenha: UITextField!
    @IBOutlet weak var bttEntrar: UIButton!
    @IBOutlet weak var lblPreencha: UILabel!
    @IBOutlet weak var segmentedOption: UISegmentedControl!
    
    override func viewDidLoad() {
        bttEntrar.layer.cornerRadius = 10
        txtEmail.delegate = self
        txtSenha.delegate = self
        
        
    }
    
    @IBAction func entrarLogin(_ sender: UIButton) {
        if(txtEmail.text!.isEmpty || txtSenha.text!.isEmpty) {
            lblPreencha.isHidden = false
        } else {
            if(segmentedOption.selectedSegmentIndex == 0) {
                lerEntradas(entidade: "Aluno")
            } else {
                lerEntradas(entidade: "Professor")
            }
            
            for i in 0...user.count-1 {
                if txtEmail.text == (user[i].value(forKey: "email") as! String) || txtEmail.text == (user[i].value(forKey: "apelido") as! String) {
                    if(txtSenha.text == (user[i].value(forKey: "senha") as! String)) {
                        lblPreencha.isHidden = true
                        self.performSegue(withIdentifier: "bemSucedido", sender: self)
                    } else {
                        lblPreencha.text = "Credenciais incorretas"
                        lblPreencha.isHidden = false
                    }
                } else {
                    lblPreencha.text = "Credenciais incorretas"
                    lblPreencha.isHidden = false
                }
            }
        }
        
    }
    
    
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        textField.resignFirstResponder()
        return true
    }
    
    func lerEntradas(entidade: String){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
          return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entidade)
        
        do {
            user = try managedContext.fetch(fetchRequest).reversed()
                } catch let error as NSError {
            print("Não foi possível carregar os dados. \(error), \(error.userInfo)")
            }
    }
}
