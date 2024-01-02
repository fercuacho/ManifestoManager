//
//  TeamDetailViewController.swift
//  ManifestoManager
//
//  Created by José Fernando Cristóbal Huerta on 27/12/23.
//

import UIKit
import CoreData

class TeamDetailViewController: UIViewController {
    
    var teamRecived : Team?
    var selectedMember : User?
    
    @IBOutlet weak var teamNameLabel: UILabel!
    
    @IBAction func addMember(_ sender: Any) {
        //Create Alert
        let alert = UIAlertController(title: "Add member", message: "What is your member's name?", preferredStyle: .alert)
        alert.addTextField()
        
        //Configure button handler
        let submitButton = UIAlertAction(title: "Add", style: .default){ (action) in
            
            //Get the textfield for the alert
            let textfield = alert.textFields![0]
            
            //Create a team objet
            let newMember = User(context: self.context)
            newMember.name = textfield.text
        
            let uniqueIdentifier = UUID()
            newMember.identificador = uniqueIdentifier
            
            newMember.team = self.teamRecived
            
            
            if let currentMembers = self.teamRecived?.members as? Set<User> {
                newMember.position = Int64(currentMembers.count)
            }
            
            //Save the data
            do{
                try self.context.save()
            }
            catch{
                
            }
            
            //Re-fetch the data
            self.fetchMembers()
            
        }
        //Add button
        alert.addAction(submitButton)
        self.present(alert, animated: true, completion: nil)
        
    }
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    @IBOutlet weak var membersTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        teamNameLabel.text = teamRecived?.name
        
        
        membersTable.dataSource = self
        membersTable.delegate = self
        
        fetchMembers()
        
    }
    
    func fetchMembers() {

        do {
            // Crear una solicitud de recuperación para los miembros del equipo específico
            let request: NSFetchRequest<User> = User.fetchRequest()
            
            // Configurar el predicado para filtrar solo los usuarios que son miembros del equipo actual
            let pred = NSPredicate(format: "team == %@", teamRecived!)
            request.predicate = pred
            
            let sortDescriptor = NSSortDescriptor(key: "position", ascending: true)
            request.sortDescriptors = [sortDescriptor]
            
            //let sort = NSSortDescriptor(key: "name", ascending: true)
            //request.sortDescriptors = [sort]
            
            // Realizar la solicitud de recuperación
            let members = try context.fetch(request)
            
            // Actualizar los datos y recargar la tabla
            teamRecived?.members = Set(members) as NSSet
            DispatchQueue.main.async {
                self.membersTable.reloadData()
            }
        } catch {
            // Manejar el error
            print("Error fetching members: \(error.localizedDescription)")
        }
    }
    
    func getMembers(team : Team) -> [User]{
        do {
            // Crear una solicitud de recuperación para los miembros del equipo específico
            let request: NSFetchRequest<User> = User.fetchRequest()
            
            // Configurar el predicado para filtrar solo los usuarios que son miembros del equipo actual
            let pred = NSPredicate(format: "team == %@", team)
            request.predicate = pred
            
            let sortDescriptor = NSSortDescriptor(key: "position", ascending: true)
            request.sortDescriptors = [sortDescriptor]
            
            // Realizar la solicitud de recuperación
            let members = try context.fetch(request)
            
            return members
            
        } catch {
            // Manejar el error
            print("Error fetching members: \(error.localizedDescription)")
            return []
        }
    }


}

extension TeamDetailViewController: UITableViewDelegate, UITableViewDataSource{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let lengthTeam = self.teamRecived?.members?.count
        return lengthTeam ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "memberCell", for: indexPath) as! MemberCellTableViewCell
                
        let members = getMembers(team: teamRecived ?? Team())
            
            if !members.isEmpty {
                let member = members[indexPath.row]
                cell.memberNameLabel.text = member.name
                
            }
        
           return cell
    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let action = UIContextualAction(style: .destructive, title: "Delete"){ (action, view, completionHandler) in
            
            
            if let team = self.teamRecived, let members = team.members as? Set<User> {
                let memberToRemove = Array(members)[indexPath.row]
                
                //Remove the member
                self.context.delete(memberToRemove)
                
                //Save the data
                do{
                    try self.context.save()
                }
                catch{
                }
                
                //Re-fetch the data
                self.fetchMembers()
            }
        }
        return UISwipeActionsConfiguration(actions: [action])
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
       
        let members = getMembers(team: teamRecived ?? Team())
            
            if !members.isEmpty {
                let member = members[indexPath.row]
                // Otras configuraciones de la celda según sea necesario
                self.performSegue(withIdentifier: "memberDetailSegue", sender: Self.self)
            
            print("Selected: ", member)
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "memberDetailSegue" {
                let destination = segue.destination as! MemberDetailViewController
                // Configurar el destino según la celda seleccionada
                if let indexPath = membersTable.indexPathForSelectedRow {
                    let members = getMembers(team: teamRecived ?? Team())
                    let selectedMember = members[indexPath.row]
                    destination.memberRecived = selectedMember
                    destination.teamRecived = teamRecived
                }
            } else if segue.identifier == "openingHoursSegue" {
                let destination = segue.destination as! OpeningHoursViewController
                destination.teamRecived2 = teamRecived
            }
    }
    
}
