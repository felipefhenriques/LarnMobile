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
        learTextView.text = aula.conteudo
        desc.text = aula.descricao
        reqTextView.text = aula.requisitos
    }
    @IBAction func bttTop(_ sender: Any) {
    }
    @IBAction func bttBottom(_ sender: Any) {
    }
    
}

extension UITextView {
    
    func resizeble(){
        self.translatesAutoresizingMaskIntoConstraints = true
        self.sizeToFit()
        self.isScrollEnabled = false
    }
}
