//
//  HomeVC.swift
//  AgendApp
//
//  Created by Queralt Sosa Mompel on 23/3/18.
//  Copyright © 2018 Queralt Sosa Mompel. All rights reserved.
//

import UIKit
import FirebaseDatabase

class HomeVC: UIViewController {
    
    @IBOutlet var myTableView: UITableView!
    
    var menu_vc : SideMenuVC!

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        menu_vc = self.storyboard?.instantiateViewController(withIdentifier: "Menu") as! SideMenuVC
        let swipeRight = UISwipeGestureRecognizer(target: self, action:#selector(self.respondToGesture))
        swipeRight.direction = UISwipeGestureRecognizerDirection.right
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action:#selector(self.respondToGesture))
        swipeRight.direction = UISwipeGestureRecognizerDirection.left
        
        self.view.addGestureRecognizer(swipeRight)
        self.view.addGestureRecognizer(swipeLeft)

    }
    
    
    @IBAction func openMenu(_ sender: Any) {
        if AppDelegate.menu_bool {
            showMenu()
        } else {
            closeMenu()
        }
    }
    
    func closeMenu() {
        menu_vc.view.removeFromSuperview()
        AppDelegate.menu_bool = true
    }
    
    func showMenu () {
        menu_vc.view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        addChildViewController(menu_vc)
        view.addSubview(menu_vc.view)
        AppDelegate.menu_bool = false
    }
    
    
    @objc func respondToGesture(gesture: UISwipeGestureRecognizer) {
        switch gesture.direction {
        case UISwipeGestureRecognizerDirection.right:
            showMenu()
        case UISwipeGestureRecognizerDirection.left:
            close_on_swipe()
        default:
            break
        }
    }
    
    
    
    func close_on_swipe() {
        if AppDelegate.menu_bool {
            showMenu()
        } else {
            closeMenu()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}

class Note {
    var date: String?
    var title: String?
    var content: String?
    
    init(date: String?, title: String?, content: String?) {
        self.date = date
        self.title = title
        self.content = content
    }
}


