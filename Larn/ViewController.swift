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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
    }
    
    func fetchData(){
        do {
            categorys = try contex.fetch(Materia.fetchRequest())
            generateCategorys()
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

}

