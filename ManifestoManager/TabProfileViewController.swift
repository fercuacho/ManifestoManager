//
//  TabProfileViewController.swift
//  ManifestoManager
//
//  Created by José Fernando Cristóbal Huerta on 01/01/24.
//

import UIKit

class TabProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

    @IBAction func logOutBtn(_ sender: Any) {
        UserDefaults.standard.removeObject(forKey: "identificador")
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let loginNavController = storyboard.instantiateViewController(identifier: "LoginNavigationController")

        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(loginNavController)
        /*
        if let navigationController = self.navigationController {
               // Pop to the root view controller (primera vista)
            print("entra")
               navigationController.popToRootViewController(animated: true)
           }
*/
    }
    

}
