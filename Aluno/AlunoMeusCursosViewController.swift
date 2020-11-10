//
//  AlunoMeusCursosViewController.swift
//  Larn
//
//  Created by Rogerio Lucon on 10/11/20.
//

import UIKit

class AlunoMeusCursosViewController: UIViewController {
    let cellIdentifier = "AlunoCursosCell"
    let contex = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var aulas: [Aula] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        fetchData()
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    //Implementar - Buscar aulas do Aluno
    func fetchData(){
        do {
            aulas = try contex.fetch(Aula.fetchRequest())
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        } catch {

        }
    }
}

extension AlunoMeusCursosViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return aulas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! AlunoTableViewCell
             
        let aula = aulas[indexPath.row]
        cell.aula = aula
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .normal, title: "Edit") { action, view, complitionHandler in
            
        }
        return UISwipeActionsConfiguration(actions: [action])
    }
    
    // Vai para a pagina do curso - Implementar
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Professor", bundle: Bundle.main)
        let registerView: RegisterClassViewController = storyboard.instantiateViewController(withIdentifier: "RegisterClass") as! RegisterClassViewController
        registerView.aula = aulas[indexPath.row]
        self.navigationController?.pushViewController(registerView, animated: true)
    }
}

