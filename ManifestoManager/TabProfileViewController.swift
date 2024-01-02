//
//  TabProfileViewController.swift
//  ManifestoManager
//
//  Created by José Fernando Cristóbal Huerta on 01/01/24.
//

import UIKit
import CoreData

class TabProfileViewController: UIViewController {

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var user : User?
    
    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var nameUser: UITextField!
    @IBOutlet weak var surnameUser: UITextField!
    @IBOutlet weak var numberUser: UITextField!
    @IBOutlet weak var emailUser: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Configura el gesto del tap para ocultar el teclado
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGesture)
        
        if let id = UserDefaults.standard.string(forKey: "identificador") {
            //Get the manager
            user = getManager(id: id)
            
            //fill up txtfields with its data
            nameUser.text = user?.name
            surnameUser.text = user?.lastname
            numberUser.text = user?.numero
            emailUser.text = user?.email
            
            profileImage.image = UIImage(named: "profile_yo.png")
            
        }

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
    
    

    @IBAction func logOutBtn(_ sender: Any) {
        UserDefaults.standard.removeObject(forKey: "identificador")
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let loginNavController = storyboard.instantiateViewController(identifier: "LoginNavigationController")

        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(loginNavController)

    }
    

    @IBAction func updateInfoBtn(_ sender: Any) {
        
        if (user != nil) {
            user?.name = nameUser.text
            user?.lastname = surnameUser.text
            user?.email = emailUser.text
            user?.numero = numberUser.text
            
            do{
                try self.context.save()
            }
            catch{
                
            }
            
        }
    }
    
    @objc func hideKeyboard() {
        view.endEditing(true)
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case nameUser:
            surnameUser.becomeFirstResponder()
        case surnameUser:
            numberUser.becomeFirstResponder()
        case numberUser:
            emailUser.becomeFirstResponder()
        case emailUser:
            emailUser.resignFirstResponder()
        default:
            break
        }
        return true
    }
    
    
    
}
