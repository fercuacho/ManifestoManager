//
//  LoginViewController.swift
//  ManifestoManager
//
//  Created by José Fernando Cristóbal Huerta on 20/12/23.
//

import UIKit
import CoreData

class LoginViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var emailTxf: UITextField!
    @IBOutlet weak var passwordTxf: UITextField!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    @IBAction func loginTapped(_ sender: UIButton) {
        
        if validateFields() {
            if var user = getUser(email: emailTxf.text!, pass: passwordTxf.text!){
                let uniqueString = user.identificador?.uuidString
                UserDefaults.standard.set(uniqueString, forKey: "identificador")
                print("IDENTIFICADOR: ", uniqueString ?? "no id")
                
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let mainTabBarController = storyboard.instantiateViewController(identifier: "MainTabBarController")
                
                (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(mainTabBarController)
                
            }

        }
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
                view.addGestureRecognizer(tapGesture)

                // Asigna el controlador delegado del textField
                emailTxf.delegate = self
                passwordTxf.delegate = self
    }
    
    func getUser(email : String, pass: String) -> User?{
        do {
            // Crear una solicitud de recuperación para los miembros del equipo específico
            let request: NSFetchRequest<User> = User.fetchRequest()
            
            // Configurar el predicado para filtrar solo los usuarios que son miembros del equipo actual
            let pred = NSPredicate(format: "email == %@", email)
            request.predicate = pred
            
            // Realizar la solicitud de recuperación
            let possibleUsers = try context.fetch(request)
                                        
            // Comparar usuarios encontrados con la contraseña
            for user in possibleUsers {
                if let storedPassword = user.password, storedPassword == pass {
                    // La contraseña coincide, devolver el usuario encontrado
                    return user
                } else {
                    showAlert(message: "Invalid password")
                }
            }
                  
            // Ningún usuario con contraseña coincidente
            showAlert(message: "Invalid user and password")

            return nil
            
        } catch {
            // Manejar el error
            print("Email no encontrado: \(error.localizedDescription)")
            return nil
        }
    }
    
    
    @objc func hideKeyboard() {
            view.endEditing(true)
        }

        // Implementa el método del delegado para manejar el retorno del teclado
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            // Cambia el primerResponder al siguiente textField o oculta el teclado si es el último
            if textField == emailTxf {
                passwordTxf.becomeFirstResponder()
            } else {
                textField.resignFirstResponder()
            }
            return true
        }
    

    func validateFields() -> Bool {
        // Verificar si el campo de correo electrónico está vacío
        guard let email = emailTxf.text, !email.isEmpty else {
            showAlert(message: "Por favor, ingresa tu correo electrónico.")
            return false
        }
        
        // Verificar si el campo de contraseña está vacío
        guard let password = passwordTxf.text, !password.isEmpty else {
            showAlert(message: "Por favor, ingresa tu contraseña.")
            return false
        }
        
        // Todos los campos están llenos
        return true
    }

    func showAlert(message: String) {
        let alertController = UIAlertController(title: "Alerta", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }

}
