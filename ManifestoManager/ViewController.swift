//
//  ViewController.swift
//  ManifestoManager
//
//  Created by José Fernando Cristóbal Huerta on 18/12/23.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var btnLogin: UIButton!
    
    @IBOutlet weak var btnSignIn: UIButton!
    
    @IBAction func goToFisrtTab(_ sender: Any) {
        
        
    }
    
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

