//
//  ViewController.swift
//  Larn
//
//  Created by Felipe Ferreira on 22/10/20.
//

import UIKit

class ViewController: UIViewController {
    
    let contex = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var categorys: [Materia] = []
    var aulas: [Aula] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
    }
    
    func fetchData(){
        do {
            categorys = try contex.fetch(Materia.fetchRequest())
            aulas = try contex.fetch(Aula.fetchRequest())
            generateCategorys()
            generateAulasTeste()
        } catch {
            
        }
    }
    
    func create(name: String){
        
        let materia = Materia(context: self.contex)
        
        materia.materia = name
        
        do {
            try contex.save()
        } catch {
            fatalError("Materia \(materia.materia) nao pode ser adicionada")
        }
    }
    
    func generateCategorys(){
        var dev = false
        var business = false
        var design = false
        var finances = false
        var marketing = false
        var artes = false
        
        for category in categorys {
            switch category.materia {
            case "Desenvolvimento":
                dev = true
            case "Negocios":
                business = true
            case "Design":
                design = true
            case "Finanças":
                finances = true
            case "Marketing":
                marketing = true
            case "Artes":
                artes = true
            default:
                break
            }
        }
        
        if !dev {
            create(name: "Desenvolvimento")
        }
        if !business {
            create(name: "Negocios")
        }
        if !design {
            create(name: "Design")
        }
        if !finances {
            create(name: "Finanças")
        }
        if !marketing {
            create(name: "Marketing")
        }
        if !artes {
            create(name: "Artes")
        }
    }
    
    private func generateAulasTeste(){
        if aulas.count < 21 {
            let tema = "Tema da Aula"
            let req = "Requisito da Aula"
            let learn = "Conteudo"
            let desc = "Descriçao"
            
            let dif = 20 - aulas.count
            
            for i in 0..<dif {
                let newAula = Aula(context: self.contex)
                newAula.id = UUID()
                
                newAula.tema = tema + "\(i)"
                newAula.materia = categorys[Int.random(in: 0..<categorys.count)]
                newAula.requisitos = req + "\(i)"
                newAula.conteudo = learn + "\(i)"
                newAula.descricao = desc + "\(i)"
                newAula.data = Date()
                newAula.valor = NSDecimalNumber(value: Int.random(in: 10..<250))
                newAula.image = UIImage(named: "estrela")?.pngData()
                do {
                    try contex.save()
                } catch {
                    fatalError("Geracao de aula falhou")
                }
            }
        }
    }
    
    private func generateDesign(){
        
    }
    
    private func generateMarketing(){
    }
    
}

