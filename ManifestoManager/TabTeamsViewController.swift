//
//  TabTeamsViewController.swift
//  ManifestoManager
//
//  Created by José Fernando Cristóbal Huerta on 20/12/23.
//

import UIKit
import CoreData

class TabTeamsViewController: UIViewController {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    @IBOutlet weak var label: UILabel!
    
    var teams:[Team]?
    
    var selectedTeam : Team?
    
    var firstTeamRecived : Team?
    
    var manager : User?
    
    var receivedData: [String: Any]?
    
    @IBOutlet weak var teamsTable: UITableView!
    
    
    @IBAction func AddNewTeam(_ sender: Any) {
        
        print("presione el boton")
        
        //Create Alert
        let alert = UIAlertController(title: "Add Team", message: "What is your team's name?", preferredStyle: .alert)
        alert.addTextField()
        
        //Configure button handler
        let submitButton = UIAlertAction(title: "Add", style: .default){ (action) in
            
            //Get the textfield for the alert
            let textfield = alert.textFields![0]
            
            //Create a team objet
            let newTeam = Team(context: self.context)
            newTeam.name = textfield.text
            
            //Attach newTeam to my manager
            
            // Obtener el conjunto actual de managerTeam
            if var existingTeams = self.manager?.managerTeam as? Set<Team> {
                // Agregar el nuevo Team al conjunto existente
                existingTeams.insert(newTeam)
                // Asignar el conjunto actualizado a managerTeam
                self.manager?.managerTeam = NSSet(array: Array(existingTeams))
                
                //Save the data
                do{
                    try self.context.save()
                }
                catch{
                    
                }
                
                //Re-fetch the data
                self.fetchTeams()
                
            }
            
        }
        //Add button
        alert.addAction(submitButton)
        self.present(alert, animated: true, completion: nil)
        
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if let valor = UserDefaults.standard.string(forKey: "identificador") {
            print("Valor recuperado: \(valor)")
            manager = getManager(id: valor)

        }
        
        
        label.text = manager?.name
        
        teamsTable.delegate = self
        teamsTable.dataSource = self
        
        fetchTeams()
        
    }
    
    func getManager(id : String) -> User{
        do {
            // Crear una solicitud de recuperación para los miembros del equipo específico
            let request: NSFetchRequest<User> = User.fetchRequest()
            
            // Configurar el predicado para filtrar solo los usuarios que son miembros del equipo actual
            let identificador = UUID(uuidString: id)
            let pred = NSPredicate(format: "identificador == %@", identificador! as CVarArg)
            request.predicate = pred
            
            // Realizar la solicitud de recuperación
            let members = try context.fetch(request)
            
            return members[0]
            
        } catch {
            // Manejar el error
            print("Error fetching members: \(error.localizedDescription)")
            return User()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    func fetchTeams(){
        //self.teams = try context.fetch(Team.fetchRequest())
        self.teams = getTeams(manager: manager ?? User())
        
        DispatchQueue.main.async {
            self.teamsTable.reloadData()
        }
        
    }
    
    func getTeams(manager : User) -> [Team]{
        do {
            // Crear una solicitud de recuperación para los miembros del equipo específico
            let request: NSFetchRequest<Team> = Team.fetchRequest()
            
            // Configurar el predicado para filtrar solo los usuarios que son miembros del equipo actual
            let pred = NSPredicate(format: "ANY managers == %@", manager)
            request.predicate = pred
            
            // Realizar la solicitud de recuperación
            let teams = try context.fetch(request)
            
            return teams
            
        } catch {
            // Manejar el error
            print("Error fetching teams for manager: \(error.localizedDescription)")
            return []
        }
    }


}

extension TabTeamsViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.teams?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "teamCell", for: indexPath) as! TeamCellTableViewCell
        
        self.teams = getTeams(manager: manager ?? User())
        
        if (self.teams != nil) {
            let team = self.teams![indexPath.row]
            cell.teamLabelName?.text = team.name
            print("EL NOMBRE DE TU TEAM ES: ", team.name ?? "no name")
        }else{
            print("no esta entrandoOOOOOO")
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let action = UIContextualAction(style: .destructive, title: "Delete"){ (action, view, completionHandler) in
            
            //Which team to remove
            let teamToRemove = self.teams![indexPath.row]
            
            //Remove the team
            self.context.delete(teamToRemove)
            
            //Save the data
            do{
                try self.context.save()
            }
            catch{
                
            }
            
            //Re-fetch the data
            self.fetchTeams()
            
        }
        
        return UISwipeActionsConfiguration(actions: [action])
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Selected: ", indexPath.row)
        
        self.teams = getTeams(manager: manager ?? User())
    
        if (self.teams != nil) {
            let team = self.teams![indexPath.row]
            selectedTeam = self.teams![indexPath.row]
            self.performSegue(withIdentifier: "teamDetailSegue", sender: Self.self)
            print("Selected: ", selectedTeam ?? "nada")

        }else{
            print("team null ref:3")
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! TeamDetailViewController
        destination.teamRecived = selectedTeam
    }
    
    
}
