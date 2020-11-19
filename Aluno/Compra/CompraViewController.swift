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
    
    var aula: Aula! {didSet { loadAula() }}
    
    override func viewDidLoad() {
        learTextView.resizeble()
        desc.resizeble()
        reqTextView.resizeble()
        
        stackView.setCustomSpacing(0, after: profName)
        
        stackView.layoutIfNeeded()
    }
    
    private func loadAula(){
        profName.text = aula.prof?.nome
        category.text = aula.materia?.materia
        // Data ajustada
        //Imagem
        learTextView.text = aula.conteudo
        desc.text = aula.descricao
        reqTextView.text = aula.requisitos
        priceTop.text = String(describing: aula.valor)
        priceBottom.text = String(describing: aula.valor)
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
