//
//  CompraViewController.swift
//  Larn
//
//  Created by Rogerio Lucon on 19/11/20.
//

import UIKit

class CompraViewController: ViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var profName: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var category: UILabel!
    @IBOutlet weak var learTextView: UITextView!
    @IBOutlet weak var desc: UITextView!
    @IBOutlet weak var reqTextView: UITextView!
    @IBOutlet weak var priceTop: UILabel!
    @IBOutlet weak var priceBottom: UILabel!
    
    var aula: Aula!
    
    override func viewDidLoad() {
        learTextView.resizeble()
        desc.resizeble()
        reqTextView.resizeble()
        
        stackView.setCustomSpacing(0, after: profName)
        
        stackView.layoutIfNeeded()
        
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadAula()
    }
    
    private func loadAula(){
        if let prof: String = aula.prof?.nome {
            profName.text = prof
        } else {
            profName.text = "Professor de Teste"
        }
        if let materia: String = aula.materia?.materia {
            category.text = materia
        }
        // Data ajustada
        imageView.image = aula.dataToImage()
        learTextView.text = aula.conteudo
        desc.text = aula.descricao
        reqTextView.text = aula.requisitos
        if let price = aula.valor {
            let aux = decimalToString(price)
            priceTop.text = aux
            priceBottom.text = aux
        }
        
        self.title = aula.tema
    }
    
    private func decimalToString(_ number: NSDecimalNumber) -> String {
        let numberFormat = NumberFormatter()
        numberFormat.numberStyle = .currency
        return "R$ \(String(describing: numberFormat.string(from: number)!))"
    }
    
    @IBAction func bttTop(_ sender: Any) {
        purchase()
    }
    @IBAction func bttBottom(_ sender: Any) {
        purchase()
    }
    
    private func purchase(){
        print("Compra realizada")
    }
    
}

extension UITextView {
    
    func resizeble(){
        self.translatesAutoresizingMaskIntoConstraints = true
        self.sizeToFit()
        self.isScrollEnabled = false
        self.isEditable = false
    }
    
}
