//
//  Cadastro.swift
//  Larn
//
//  Created by Felipe Ferreira on 27/10/20.
//

import Foundation
import UIKit
import CoreData

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
        if (txtApelido.text!.isEmpty || txtSenha.text!.isEmpty || txtEmail.text!.isEmpty) {
            lblPreencha.isHidden = false
        } else if (txtApelido.text!.count < 5){
            lblPreencha.text = "Apelido deve ter no mínimo 5 caracteres"
            lblPreencha.isHidden = false
        } else if (txtSenha.text!.count < 4){
            lblPreencha.text = "A senha deve ter no mínimo 4 caracteres"
        } else {
            lblPreencha.isHidden = true
            if(segmentedOption.selectedSegmentIndex == 0) {
                performSegue(withIdentifier: "aluno", sender: self)
            } else {
                performSegue(withIdentifier: "professor", sender: self)
        }
        }
    }
        
        
    
    //passando dados
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "aluno"){
            let vc = segue.destination as! telaCadastroAluno
            vc.apelidoAluno = txtApelido.text ?? "vazio"
            vc.senhaAluno = txtSenha.text ?? "vazio"
            vc.emailAluno = txtEmail.text ?? "vazio"
        } else if (segue.identifier == "professor"){
            let vc = segue.destination as! telaCadastroProfessor
            vc.apelidoProfessor = txtApelido.text ?? "vazio"
            vc.senhaProfessor  = txtSenha.text ?? "vazio"
            vc.emailProfessor = txtEmail.text ?? "vazio"
        }
     }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func bttApagarRegistros(_ sender: Any) {
                let context = ( UIApplication.shared.delegate as! AppDelegate ).persistentContainer.viewContext
                let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Aluno")
                let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
                do
                {
                    try context.execute(deleteRequest)
                    try context.save()
                }
                catch
                {
                    print ("There was an error")
                }
            }
    
}
    


class telaCadastroAluno: UIViewController, UITextFieldDelegate {
    
    var objetoGerenciado: NSManagedObjectContext!
    var apelidoAluno = String()
    var senhaAluno = String()
    var emailAluno = String()
    @IBOutlet weak var lblPreencha: UILabel!
    @IBOutlet weak var txtNome: UITextField!
    @IBOutlet weak var txtCpf: UITextField!
    @IBOutlet weak var dtNascimento: UIDatePicker!
    @IBOutlet weak var bttCrie: UIButton!
    
    override func viewDidLoad() {
        //Necessario para o NSManagedObjectContext não retornar nil
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        objetoGerenciado = appDelegate.persistentContainer.viewContext
        
        bttCrie.layer.cornerRadius = 10 
        
        //botao done no numberpad
        numberPadDone(textField: txtCpf)
        
        txtNome.delegate = self
        txtCpf.delegate = self
        
        
    }
    
    
    @IBAction func bttCadastrar(_ sender: UIButton) {
        if(txtNome.text!.isEmpty || txtCpf.text!.isEmpty){
            lblPreencha.isHidden = false
        } else if txtCpf.text!.count != 11{
            lblPreencha.text = "CPF inválido"
            lblPreencha.isHidden = false
        } else {
            lblPreencha.isHidden = true
            cadastraAluno()
            performSegue(withIdentifier: "mostraAluno", sender: self)
        }
    }
    
    //Função para adicionar botão done no number pad
    func numberPadDone(textField: UITextField) {
        let keyboardToolbar = UIToolbar()
        keyboardToolbar.sizeToFit()
        let flexBarButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
            target: nil, action: nil)
        let doneBarButton = UIBarButtonItem(barButtonSystemItem: .done,
            target: view, action: #selector(UIView.endEditing(_:)))
        keyboardToolbar.items = [flexBarButton, doneBarButton]
        textField.inputAccessoryView = keyboardToolbar
    }
    
    func cadastraAluno(){
        let entidadeEntrada = NSEntityDescription.entity(forEntityName: "Aluno", in: self.objetoGerenciado)
        let objetoEntrada = NSManagedObject(entity: entidadeEntrada!, insertInto: self.objetoGerenciado)

        objetoEntrada.setValue(apelidoAluno, forKey: "apelido")
        objetoEntrada.setValue(senhaAluno, forKey: "senha")
        objetoEntrada.setValue(emailAluno, forKey: "email")
        objetoEntrada.setValue(txtNome.text, forKey: "nome")
        objetoEntrada.setValue(txtCpf.text, forKey: "cpf")
        objetoEntrada.setValue(dtNascimento.date, forKey: "dataNascimento")
        objetoEntrada.setValue(true, forKey: "isAluno")
        
        do {
            try objetoGerenciado.save()
        } catch let error as NSError {
            print("Não foi possível salvar a entrada \(error.description)")
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        textField.resignFirstResponder()
        return true
    }
    
}

class telaCadastroProfessor: UIViewController, UITextFieldDelegate {
    
    var objetoGerenciado: NSManagedObjectContext!
    var apelidoProfessor = String()
    var senhaProfessor = String()
    var emailProfessor = String()
    @IBOutlet weak var lblPreencha: UILabel!
    @IBOutlet weak var txtNome: UITextField!
    @IBOutlet weak var txtCpf: UITextField!
    @IBOutlet weak var dtNascimento: UIDatePicker!
    @IBOutlet weak var txtLattes: UITextField!
    @IBOutlet weak var bttCriar: UIButton!
    
    override func viewDidLoad() {
        //Necessario para o NSManagedObjectContext não retornar nil
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        objetoGerenciado = appDelegate.persistentContainer.viewContext
        
        bttCriar.layer.cornerRadius = 10
        
        txtNome.delegate = self
        txtCpf.delegate = self
        txtLattes.delegate = self
        
        numberPadDone(textField: txtCpf)
    }
    
    @IBAction func bttCadastrar(_ sender: Any) {
        if(txtNome.text!.isEmpty || txtCpf.text!.isEmpty){
            lblPreencha.isHidden = false
        } else if txtCpf.text!.count != 11{
            lblPreencha.text = "CPF inválido"
            lblPreencha.isHidden = false
        } else {
            lblPreencha.isHidden = true
            cadastraProfessor()
            performSegue(withIdentifier: "mostraProfessor", sender: self)
        }
    }
    
    
    func cadastraProfessor(){
        let entidadeEntrada = NSEntityDescription.entity(forEntityName: "Professor", in: self.objetoGerenciado)
        let objetoEntrada = NSManagedObject(entity: entidadeEntrada!, insertInto: self.objetoGerenciado)

        objetoEntrada.setValue(apelidoProfessor, forKey: "apelido")
        objetoEntrada.setValue(senhaProfessor, forKey: "senha")
        objetoEntrada.setValue(emailProfessor, forKey: "email")
        objetoEntrada.setValue(txtNome.text, forKey: "nome")
        objetoEntrada.setValue(txtCpf.text, forKey: "cpf")
        objetoEntrada.setValue(dtNascimento.date, forKey: "dataNascimento")
        objetoEntrada.setValue(false, forKey: "isAluno")
        objetoEntrada.setValue(txtLattes.text, forKey: "lattes")
        
        do {
            try objetoGerenciado.save()
        } catch let error as NSError {
            print("Não foi possível salvar a entrada \(error.description)")
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        textField.resignFirstResponder()
        return true
    }
    
    //Função para adicionar botão done no number pad
    func numberPadDone(textField: UITextField) {
        let keyboardToolbar = UIToolbar()
        keyboardToolbar.sizeToFit()
        let flexBarButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
            target: nil, action: nil)
        let doneBarButton = UIBarButtonItem(barButtonSystemItem: .done,
            target: view, action: #selector(UIView.endEditing(_:)))
        keyboardToolbar.items = [flexBarButton, doneBarButton]
        textField.inputAccessoryView = keyboardToolbar
    }
    
}

class carregaDados: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var segmentedOption: UISegmentedControl!
    var user:[NSManagedObject] = []
    @IBOutlet weak var lblApelido: UILabel!
    @IBOutlet weak var lblSenha: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblNome: UILabel!
    @IBOutlet weak var lblCpf: UILabel!
    @IBOutlet weak var lblDataNascimento: UILabel!
    @IBOutlet weak var lblisAluno: UILabel!
    @IBOutlet weak var lblUrl: UILabel!
    @IBOutlet weak var txtEntrada: UITextField!
    var dateFormatter = DateFormatter()
    
    
    override func viewDidLoad() {
        lblUrl.isHidden = true
        txtEntrada.delegate = self
        
        dateFormatter.dateFormat = "dd-MM-yyyy"
        
        
    }
    
    @IBAction func mudaUser(_ sender: UISegmentedControl) {
        
    }
    @IBAction func voltarHome(_ sender: UIButton) {
        performSegue(withIdentifier: "voltaHome", sender: self)
    }
    
    @IBAction func bttBuscar(_ sender: Any) {
        if(segmentedOption.selectedSegmentIndex == 0) {
            lerEntradas(entidade: "Aluno")
            for i in 0...user.count-1{
                if (user[i].value(forKey: "cpf") as! String) == txtEntrada.text {
                    lblApelido.text = (user[i].value(forKey: "apelido") as! String)
                    lblSenha.text = (user[i].value(forKey: "senha") as! String)
                    lblEmail.text = (user[i].value(forKey: "email") as! String)
                    lblNome.text = (user[i].value(forKey: "nome") as! String)
                    lblCpf.text = (user[i].value(forKey: "cpf") as! String)
                    lblDataNascimento.text = dateFormatter.string(from: user[i].value(forKey: "dataNascimento") as! Date)
                    lblisAluno.text = String((user[i].value(forKey: "isAluno") as! Bool))
                    lblUrl.isHidden = true
                    break
                } else {
                    lblApelido.text = "Não tem"
                    lblSenha.text = "Não tem"
                    lblEmail.text = "Não tem"
                    lblEmail.text = "Não tem"
                    lblNome.text = "Não tem"
                    lblCpf.text = "Não tem"
                    lblDataNascimento.text = "Não tem"
                    lblisAluno.text = "Não tem"
                    lblUrl.isHidden = true
                }
            }
                    
        }  else {
            lerEntradas(entidade: "Professor")
            for i in 0...user.count-1 {
                if (user[i].value(forKey: "cpf") as! String) == txtEntrada.text{
                    lblApelido.text = (user[i].value(forKey: "apelido") as! String)
                    lblSenha.text = (user[i].value(forKey: "senha") as! String)
                    lblEmail.text = (user[i].value(forKey: "email") as! String)
                    lblNome.text = (user[i].value(forKey: "nome") as! String)
                    lblCpf.text = (user[i].value(forKey: "cpf") as! String)
                    lblDataNascimento.text = dateFormatter.string(from: user[i].value(forKey: "dataNascimento") as! Date)
                    lblisAluno.text = String((user[i].value(forKey: "isAluno") as! Bool))
                    lblUrl.isHidden = false
                    lblUrl.text = (user[i].value(forKey: "lattes") as! String)
                } else {
                    lblApelido.text = "Não tem"
                    lblSenha.text = "Não tem"
                    lblEmail.text = "Não tem"
                    lblEmail.text = "Não tem"
                    lblNome.text = "Não tem"
                    lblCpf.text = "Não tem"
                    lblDataNascimento.text = "Não tem"
                    lblisAluno.text = "Não tem"
                    lblUrl.text = "Não tem"
                }
        }
    }
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
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        textField.resignFirstResponder()
        return true
    }
    
}



