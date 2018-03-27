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
                
                if let errCode = FIRAuthErrorCode(rawValue: (error?._code)!) {
                    switch errCode {
                    case .errorCodeInvalidEmail:
                        self.showAlert("Enter a valid email.")
                    case .errorCodeEmailAlreadyInUse:
                        self.showAlert("Email already in use.")
                    default:
                        self.showAlert("Error: \(String(describing: error?.localizedDescription))")
                    }
                }
            }
            else {
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "Login")
                self.present(vc!, animated: true, completion: nil)
            }
        })
    }
    
    
    func showAlert(_ message: String) {
        let alertController = UIAlertController(title: "There was an error", message: message, preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "Ok, I will try again", style: UIAlertActionStyle.default,handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
    
    
        
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
