//
//  CreateFirstTeamViewController.swift
//  ManifestoManager
//
//  Created by José Fernando Cristóbal Huerta on 01/01/24.
//

import UIKit

class CreateFirstTeamViewController: UIViewController {

    var managerRecived : User?
    var firstTeam : Team?

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var teamNameTxf: UITextField!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    

    @IBAction func createFirstTeam(_ sender: Any) {
        
        if (teamNameTxf.text != nil){
            
            firstTeam = Team(context: self.context)
            firstTeam?.name = teamNameTxf.text
            
            self.managerRecived?.team = firstTeam
            
            //if let currentMembers = self.firstTeam?.members as? Set<User> {
            //    managerRecived?.position = Int64(currentMembers.count)
            //}
            
            if let team = firstTeam {
                self.managerRecived?.managerTeam = NSSet(object: team)
            }

            //Save the data
            do{
                try self.context.save()
            }
            catch{
                
            }
            
            if let managers = firstTeam?.managers {
                for mana in managers {
                    if let manager = mana as? User {
                        print("el nombre de tu team: ", firstTeam?.name ?? "name team")
                        
                        print("Es: ", manager.name ?? "no name")
                    }
                }
            } else {
                print("El conjunto de managers es nulo")
            }
            
            
            //performSegue(withIdentifier: "firstTeamSegue", sender: self)

            /*
            if let tabBarVC = storyboard?.instantiateViewController(withIdentifier: "MainTabBarController") as? TabBarController {
                   // Configura los controladores de vista que estarán dentro de las pestañas del UITabBarController
                   let Teams = TabTeamsViewController()
                   let Profile = TabProfileViewController()

                   tabBarVC.setViewControllers([Teams, Profile], animated: false)
                
                //tabBarVC.dataToPass = ["firstTeam":firstTeam!, "manager":managerRecived!]

                   // Realiza la transición sin mostrar el botón de retroceso y sin presentar modalmente
                   navigationController?.setViewControllers([tabBarVC], animated: true)
               }
            */
        }else {
            
        }
            
    }
    
    //override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      //  let destination = segue.destination as! TabTeamsViewController
        //destination.firstTeamRecived = firstTeam
       // destination.manager = managerRecived
   // }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let tabBarController = segue.destination as? UITabBarController,
            let firstViewController = tabBarController.viewControllers?.first as? TabTeamsViewController {
            //firstViewController.manager = managerRecived
            //firstViewController.firstTeamRecived = firstTeam
            // O llamar a un método
            // firstViewController.updateData(yourData)
        }
    }
    

}
