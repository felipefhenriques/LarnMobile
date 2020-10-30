//
//  Cadastro.swift
//  Larn
//
//  Created by Felipe Ferreira on 27/10/20.
//

import Foundation
import UIKit

class telaInicialCadastro: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var bttContinuar: UIButton!
    @IBOutlet weak var segmentedOption: UISegmentedControl!
    @IBOutlet weak var txtApelido: UITextField!
    @IBOutlet weak var txtSenha: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var lblPreencha: UILabel!
    
    override func viewDidLoad() {
        bttContinuar.layer.cornerRadius = 10
        segmentedOption.titleForSegment(at: 0)
        txtApelido.delegate = self
        txtSenha.delegate = self
        txtEmail.delegate = self
    }
    
    @IBAction func bttContinuar(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Cadastro", bundle: nil)
        
        if (txtApelido.text!.isEmpty || txtSenha.text!.isEmpty || txtEmail.text!.isEmpty) {
            lblPreencha.isHidden = false
        } else {
            lblPreencha.isHidden = true
            if(segmentedOption.selectedSegmentIndex == 0) {
                let controller = storyboard.instantiateViewController(withIdentifier: "aluno")
                self.present(controller, animated: true, completion: nil)
            } else {
                let controller = storyboard.instantiateViewController(withIdentifier: "professor")
                self.present(controller, animated: true, completion: nil)
            }
        }
    }
    
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        textField.resignFirstResponder()
        return true
    }
    
}

class telaCadastroAluno: UIViewController {
    
    override func viewDidLoad() {
        
    }
    
}

class telaCadastroProfessor: UIViewController {
    
}

