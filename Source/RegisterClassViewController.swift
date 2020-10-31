//
//  RegisterClassViewController.swift
//  Larn
//
//  Created by Rogerio Lucon on 30/10/20.
//

import UIKit

class RegisterClassViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    let contex = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var tema: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var learn: UITextView!
    @IBOutlet weak var des: UITextView!
    @IBOutlet weak var req: UITextView!
    @IBOutlet weak var price: UITextField!
    
    var reloadDelegate: ReloadDelegate!
    
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
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        picker.sourceType = .photoLibrary
        present(picker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    guard let userPickedImage = info[.editedImage] as? UIImage else { return }
    image.image = userPickedImage
    picker.dismiss(animated: true)
    }
    
    @IBAction func publish(_ sender: Any) {
        
        if let validation = validateInputs() {
            alert(title: "Falha", message: validation)
            return
        }
        
        let aula = Aula(context: self.contex)
        aula.tema = tema.text
        aula.requisitos = req.text
        aula.conteudo = learn.text
        aula.descricao = des.text
        aula.data = datePicker.date
        aula.valor = NSDecimalNumber(string: price.text)
        aula.image = image.image?.pngData()
        do {
            try contex.save()
            reload()
        } catch {
            alert(title: "Erro", message: "Erro ao cadastrar na base de dados")
        }
    }
    
    func validateInputs() -> String?{
        var menssage: String = ""
        
        if let text = tema.text, text.isEmpty{
            menssage.append("Tema é um campo obrigatorio!\n")
        }
        if let text = learn.text, text.isEmpty{
            menssage.append("O campo 'O que irei aprender?' é obrigatorio!\n")
        }
        if let text = des.text, text.isEmpty{
            menssage.append("O campo Descriçao é obrigatorio!\n")
        }
        if let text = req.text, text.isEmpty{
            menssage.append("O campo Requisitos é obrigatorio!\n")
        }
        if let text = price.text, text.isEmpty{
            menssage.append("O campo Preço é obrigatorio!\n")
        }
        return menssage.count > 1 ? menssage : nil
    }
    
    func alert(title: String, message: String, handler: @escaping (UIAlertAction) -> Void = {_ in }) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Dismiss", style: .cancel, handler: handler)
        alert.addAction(action)
        present(alert, animated: true)
    }
}

extension  RegisterClassViewController: ReloadDelegate {
    
    func reload() {
        reloadDelegate.reload()
        alert(title: "Sucesso", message: "Aula adicionada com sucesso") {_ in
            self.navigationController?.popViewController(animated: true)
        }
        
    }
}
