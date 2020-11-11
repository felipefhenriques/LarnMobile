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
    @IBOutlet weak var materiaPicker: UIPickerView!
    @IBOutlet weak var tema: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var learn: UITextView!
    @IBOutlet weak var des: UITextView!
    @IBOutlet weak var req: UITextView!
    @IBOutlet weak var price: UITextField!
    
    var reloadDelegate: ReloadDelegate!
    
    var aula: Aula?
    
    override func viewDidLoad() {
        materiaPicker.delegate = self
        materiaPicker.dataSource = self
        if #available(iOS 13.4, *) {
                datePicker.preferredDatePickerStyle = .compact
               
        }
        configElements()
        
        if aula != nil {
            loadAula()
        }
        print("Teste")
    }
    
    private func configElements(){
        //Image
        let tap = UITapGestureRecognizer(target: self, action: #selector (changeImage))
        image.isUserInteractionEnabled = true
        image.addGestureRecognizer(tap)
        
        self.title = "Aula"
    }
    
    @objc private func changeImage(){
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
    
    // Refatorar  Melhorar
    @IBAction private func publish(_ sender: Any) {
        
        if let validation = validateInputs() {
            alert(title: "Falha", message: validation)
            return
        }
        
        var aulaAltera:Aula
        if let aula = aula {
            aulaAltera = aula
        } else {
            aulaAltera = Aula(context: self.contex)
            aulaAltera.id = UUID()
        }
        aulaAltera.tema = tema.text
        aulaAltera.materia = categorys[materiaPicker.selectedRow(inComponent: 0)]
        aulaAltera.requisitos = req.text
        aulaAltera.conteudo = learn.text
        aulaAltera.descricao = des.text
        aulaAltera.data = datePicker.date
        aulaAltera.valor = NSDecimalNumber(string: price.text)
        aulaAltera.image = image.image?.pngData()
        do {
            try contex.save()
            reload()
        } catch {
            alert(title: "Erro", message: "Erro ao cadastrar na base de dados")
        }
    }
    
    private func validateInputs() -> String?{
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
    
    private func alert(title: String, message: String, handler: @escaping (UIAlertAction) -> Void = {_ in }) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Dismiss", style: .cancel, handler: handler)
        alert.addAction(action)
        present(alert, animated: true)
    }
    
    func loadAula() {
        if let aula = self.aula {
            tema.text = aula.tema
            req.text = aula.requisitos
            learn.text = aula.conteudo
            des.text = self.aula?.descricao
            datePicker.date = self.aula?.data ?? Date()
            let index = categorys.firstIndex {$0.materia == aula.materia?.materia}
            materiaPicker.selectRow(index ?? 0, inComponent: 0, animated: false)
            if let valor = aula.valor {
                price.text = valor.stringValue
            }
            if let imgData = aula.image {
                image.image = UIImage(data: imgData)
            }
            
        }
        
        self.navigationItem.rightBarButtonItem  = self.editButtonItem
        
        setEditing(false, animated: false)
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing,animated:animated)
        image.isUserInteractionEnabled = editing
        tema.isEnabled = editing
        datePicker.isEnabled = editing
        learn.isUserInteractionEnabled = editing
        des.isUserInteractionEnabled = editing
        req.isUserInteractionEnabled = editing
        price.isEnabled = editing
        materiaPicker.isUserInteractionEnabled = editing
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

 

extension  RegisterClassViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    var categorys: [Materia] {get { fetchData() }}
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
        
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categorys.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return categorys[row].materia
    }
    
    func fetchData() -> [Materia]{
        do {
            return try contex.fetch(Materia.fetchRequest())
        } catch {
            fatalError("Problema para puxar as materias")
        }
    }
    
}
