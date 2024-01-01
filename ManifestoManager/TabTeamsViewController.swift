//
//  TabTeamsViewController.swift
//  ManifestoManager
//
//  Created by José Fernando Cristóbal Huerta on 20/12/23.
//

import UIKit

class TabTeamsViewController: UIViewController {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var teams:[Team]?
    
    var selectedTeam : Team?
    
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
        
            //Save the data
            do{
                try self.context.save()
            }
            catch{
                
            }
            
            //Re-fetch the data
            self.fetchTeams()
            
        }
        //Add button
        alert.addAction(submitButton)
        self.present(alert, animated: true, completion: nil)
        
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        teamsTable.delegate = self
        teamsTable.dataSource = self
        
        fetchTeams()
        
    }
    
    func fetchTeams(){
        do{
            self.teams = try context.fetch(Team.fetchRequest())
            
            DispatchQueue.main.async {
                self.teamsTable.reloadData()
            }
        }catch{
            
        }
    }


}

extension TabTeamsViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.teams?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "teamCell", for: indexPath) as! TeamCellTableViewCell
        
        let team = self.teams![indexPath.row]
        
        cell.teamLabelName?.text = team.name
        
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
        selectedTeam = self.teams![indexPath.row]
        self.performSegue(withIdentifier: "teamDetailSegue", sender: Self.self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! TeamDetailViewController
        destination.teamRecived = selectedTeam
    }
    
    
}
