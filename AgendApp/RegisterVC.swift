//
//  RegisterVC.swift
//  AgendApp
//
//  Created by Queralt Sosa Mompel on 20/3/18.
//  Copyright © 2018 Queralt Sosa Mompel. All rights reserved.
//

import UIKit
import Firebase

class RegisterVC: UIViewController {

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    @IBOutlet weak var background: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        background.addBlurEffect()
    }
    
    
    @IBAction func register(_ sender: Any) {
        FIRAuth.auth()?.createUser(withEmail: email.text!, password: password.text!, completion: {
            user, error in
            if error != nil {
                let alertController = UIAlertController(title: "There was an error", message: error?.localizedDescription, preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: "Ok, I will try again", style: .cancel, handler: nil)
                alertController.addAction(defaultAction)
                self.present(alertController, animated: true, completion: nil)
            }
            else {
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "Login")
                self.present(vc!, animated: true, completion: nil)
            }
        })
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
