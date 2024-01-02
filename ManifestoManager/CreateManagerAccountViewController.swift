//
//  CreateManagerAccountViewController.swift
//  ManifestoManager
//
//  Created by José Fernando Cristóbal Huerta on 31/12/23.
//

import UIKit

class CreateManagerAccountViewController: UIViewController,  UITextFieldDelegate {

    var manager : User?
    
    @IBOutlet weak var nameTxf: UITextField!
    @IBOutlet weak var surnameTxf: UITextField!
    @IBOutlet weak var numberTxf: UITextField!
    @IBOutlet weak var emailTxf: UITextField!
    @IBOutlet weak var passwordTxf: UITextField!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
            super.viewDidLoad()

            // Configura el gesto del tap para ocultar el teclado
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
            view.addGestureRecognizer(tapGesture)

            // Asigna el controlador delegado de los textFields
            nameTxf.delegate = self
            surnameTxf.delegate = self
            numberTxf.delegate = self
            emailTxf.delegate = self
            passwordTxf.delegate = self
        }

        @objc func hideKeyboard() {
            view.endEditing(true)
        }

        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            switch textField {
            case nameTxf:
                surnameTxf.becomeFirstResponder()
            case surnameTxf:
                numberTxf.becomeFirstResponder()
            case numberTxf:
                emailTxf.becomeFirstResponder()
            case emailTxf:
                passwordTxf.becomeFirstResponder()
            case passwordTxf:
                passwordTxf.resignFirstResponder()
            default:
                break
            }
            return true
        }
    
    
    @IBAction func createManagerAccount(_ sender: Any) {
        
        manager = User(context: self.context)
        manager?.name = nameTxf.text
        manager?.lastname = surnameTxf.text
        manager?.numero = numberTxf.text
        manager?.email = emailTxf.text
        manager?.password = passwordTxf.text
        let uniqueIdentifier = UUID()
        manager?.identificador = uniqueIdentifier
        
        let uniqueString = manager?.identificador?.uuidString
        UserDefaults.standard.set(uniqueString, forKey: "identificador")
        print("IDENTIFICADOR: ", uniqueString ?? "no id")
        
        //Save the data
        do{
            try self.context.save()
        }
        catch{
        }
        
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! CreateFirstTeamViewController
        destination.managerRecived = manager
    }
    
    
}
