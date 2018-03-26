//
//  SideMenuVC.swift
//  AgendApp
//
//  Created by Queralt Sosa Mompel on 23/3/18.
//  Copyright © 2018 Queralt Sosa Mompel. All rights reserved.
//

import UIKit
import Firebase

class SideMenuVC: UIViewController {
var menu_vc : SideMenuVC!
    
    @IBOutlet weak var background: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        background.addBlurEffect()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func logout(_ sender: Any) {
        if FIRAuth.auth()?.currentUser != nil {
            do {
                try FIRAuth.auth()?.signOut()
                
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "Index") as! ViewController
                present(vc, animated: true, completion: nil)
                
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
    }
    
    
    @IBAction func deleteAccount(_ sender: Any) {
        let user = FIRAuth.auth()?.currentUser
        user?.delete (completion: { (error) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "Index") as! ViewController
                self.present(vc, animated: true, completion: nil)
            }
        })
    }
    

}

