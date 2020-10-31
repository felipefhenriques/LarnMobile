//
//  ProfessorHomeViewController.swift
//  Larn
//
//  Created by Rogerio Lucon on 29/10/20.
//
import UIKit
import Foundation

class ProfessorHomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    let cellIdentifier = "CellIdentifier"
    let contex = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var aulas: [Aula] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        fetchData()
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return aulas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! CustomTableViewCell
             
        // Fetch Fruit
        let fruit = aulas[indexPath.row]
         
        // Configure Cell
        cell.title.text = fruit.tema
        cell.sold.text = String(indexPath.row)
        if let data = fruit.image {
            cell.img.image = UIImage(data: data)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .normal, title: "Edit") { action, view, complitionHandler in
            
        }
        
        return UISwipeActionsConfiguration(actions: [action])
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
        let registerView: RegisterClassViewConroller = storyboard.instantiateViewController(withIdentifier: "RegisterClass") as! RegisterClassViewConroller
        registerView.reloadDelegate = self
        self.navigationController?.pushViewController(registerView, animated: true)
    }
}

extension ProfessorHomeViewController: ReloadDelegate {
    
    func reload() {
        fetchData()
    }

}
