//
//  ProfessorHomeViewController.swift
//  Larn
//
//  Created by Rogerio Lucon on 29/10/20.
//
import UIKit
import Foundation

class ProfessorHomeViewController: UIViewController {
    
    let cellIdentifier = "CellIdentifier"
    let contex = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var aulas: [Aula] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        fetchData()
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func fetchData(){
        do {
            aulas = try contex.fetch(Aula.fetchRequest())
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        } catch {

        }
    }
    
    @IBAction func addClass(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Professor", bundle: Bundle.main)
        let registerView: RegisterClassViewController = storyboard.instantiateViewController(withIdentifier: "RegisterClass") as! RegisterClassViewController
        registerView.reloadDelegate = self
        self.navigationController?.pushViewController(registerView, animated: true)
    }
}

extension ProfessorHomeViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return aulas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! CustomTableViewCell
             
        // Fetch Fruit
        let aula = aulas[indexPath.row]
        cell.aula = aula
        // Configure Cell
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .normal, title: "Edit") { action, view, complitionHandler in
            
        }
        
        return UISwipeActionsConfiguration(actions: [action])
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Professor", bundle: Bundle.main)
        let registerView: RegisterClassViewController = storyboard.instantiateViewController(withIdentifier: "RegisterClass") as! RegisterClassViewController
        print(aulas[indexPath.row].tema)
        registerView.aula = aulas[indexPath.row]
        registerView.reloadDelegate = self
        self.navigationController?.pushViewController(registerView, animated: true)
    }
}

extension ProfessorHomeViewController: ReloadDelegate {
    
    func reload() {
        fetchData()
    }

}
