//
//  Busca.swift
//  Larn
//
//  Created by Felipe Ferreira on 10/11/20.
//

import Foundation
import UIKit
import CoreData

class buscaTable: UITableViewController {
    
    var materias:[NSManagedObject] = []
    var auxMateria = String()
    
    
    override func viewDidLoad() {
        lerMaterias()
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }
    
    func lerMaterias(){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
          return
        }

        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Materia")

        do {
            materias = try managedContext.fetch(fetchRequest).reversed()
            self.tableView.reloadData()
        } catch let error as NSError {
          print("Não foi possível carregar os dados. \(error), \(error.userInfo)")
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let materiaSelecionada = self.materias[indexPath.row].value(forKey: "materia") as! String
        performSegue(withIdentifier: "segueMateria", sender: materiaSelecionada)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return materias.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let materia = materias[indexPath.row]
        var cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        if cell.textLabel == nil || cell.detailTextLabel == nil {
            cell = UITableViewCell(style: .value1, reuseIdentifier: "Cell")
        }
        
        cell.textLabel?.text = materia.value(forKey: "materia") as? String
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueMateria"{
            let vc = segue.destination as! buscaMaterias
            vc.materia = sender as! String
        }
    }
    
    @IBAction func bttCancela(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}

class buscaMaterias: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var navigationBar: UINavigationBar!
    var materia = String()
    var aulas:[NSManagedObject] = []
    var dataSource: UITableViewDiffableDataSource<Section, Aula>?
    @IBOutlet weak var tblAulas: UITableView!
    
    private var aulaSelecionada: Aula?
    
    override func viewDidLoad() {
        lerEntradas()
        tblAulas.delegate = self
        tblAulas.dataSource = self
        tblAulas.rowHeight = 85
        
        navigationBar.topItem?.title = materia
        print(materia)
    }
    
    
    func lerEntradas(){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
          return
        }

        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Aula")
        let predicate = NSPredicate(format: "ANY materia.materia ==%@", materia)

        fetchRequest.predicate = predicate
        
        do {
            aulas = try managedContext.fetch(fetchRequest).reversed()
            self.tblAulas.reloadData()
        } catch let error as NSError {
          print("Não foi possível carregar os dados. \(error), \(error.userInfo)")
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return aulas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! customCell
        let aula = aulas[indexPath.row]
        let valorAula: Decimal = aula.value(forKey: "valor") as! Decimal
        let icon = defineIcon(materia: materia)
        
        cell.lblTitulo.text = aula.value(forKey: "tema") as? String
        cell.lblNomeProf.text = aula.value(forKeyPath: "prof.nome") as? String
        cell.lblValor.text = "R$" + NSDecimalNumber(decimal: valorAula).stringValue
        if(icon != ""){
            cell.viewImg.image = UIImage(named: icon)
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        aulaSelecionada = aulas[indexPath.row] as? Aula
        performSegue(withIdentifier: "ComprarAula", sender: nil)
    }
    
    @IBAction func btnDismiss(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func defineIcon(materia: String) -> String{
        switch(materia){
        case "Artes":
            return "artes"
        case "Marketing":
            return "marketing"
        case "Finanças":
            return "financas"
        case "Design":
            return "design"
        case "Negócios":
            return "negocios"
        case "Desenvolvimento":
            return "desenvolvimento"
        default:
            return ""
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ComprarAula" {
            let destination = segue.destination as? CompraViewController
            
            destination?.aula = aulaSelecionada
        }
    }
    
}

class customCell: UITableViewCell {
    @IBOutlet weak var lblTitulo: UILabel!
    @IBOutlet weak var lblNomeProf: UILabel!
    @IBOutlet weak var lblValor: UILabel!
    @IBOutlet weak var viewImg: UIImageView!
    
}
  
    
    

