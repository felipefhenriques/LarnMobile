//
//  RegisterClassViewController.swift
//  Larn
//
//  Created by Rogerio Lucon on 30/10/20.
//

import UIKit

class RegisterClassViewConroller: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
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
    
    //Falta atualizar quando publicar
    @IBAction func publish(_ sender: Any) {
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
            alert()
        }
    }
    
    func alert() {
        let alert = UIAlertController(title: "Erro", message: "Erro ao cadastrar na base de dados", preferredStyle: .alert)
        let action = UIAlertAction(title: "Dismiss", style: .cancel)
        alert.addAction(action)
        present(alert, animated: true)
    }
}

extension  RegisterClassViewConroller: ReloadDelegate {
    
    func reload() {
        reloadDelegate.reload()
        self.navigationController?.popViewController(animated: true)
    }
}
