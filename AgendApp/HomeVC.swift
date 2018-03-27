//
//  HomeVC.swift
//  AgendApp
//
//  Created by Queralt Sosa Mompel on 23/3/18.
//  Copyright © 2018 Queralt Sosa Mompel. All rights reserved.
//

import UIKit
import FirebaseDatabase
import Firebase


class HomeVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var menu_vc : SideMenuVC!
    var items = [Note]()
    
    @IBOutlet var myTableView: UITableView!


     func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return items.count
    }
    
    
      func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if(indexPath.row > items.count-1){
            return UITableViewCell()
        }
        else{
            let cell = myTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCellNotes
            
            let item = items[indexPath.row]
            cell.content?.text = item.content
            cell.title?.text = item.title
            cell.date?.text = item.date
            return cell
        }
    }
    
    func loadDataFromFirebase() {
        let ref = FIRDatabase.database().reference().child("notes")
        ref.observeSingleEvent(of: .value, with: { snapshot in
            var newItems = [Note]()
            
            for rest in snapshot.children.allObjects as! [FIRDataSnapshot] {
                guard let restDict = rest.value as? [String: Any] else { continue }
                let title = restDict["title"] as? String
                let date = restDict["date"] as? String
                let content = restDict["content"] as? String
                
                let idUser = restDict["idUser"] as? String
                let userID = FIRAuth.auth()?.currentUser?.uid
                
                if (idUser == userID ) {
                    let note = Note(date: date!, title: title!, content: content!)
                    newItems.append(note)
                }
            }
            
            self.items = newItems
            self.myTableView.reloadData()
        })
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        myTableView.dataSource = self as UITableViewDataSource
        myTableView.delegate = self as UITableViewDelegate

        loadDataFromFirebase()
        
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
    }
    
}

struct Note {
    var date: String
    var title: String
    var content: String
    
    init(date: String, title: String, content: String) {
        self.date = date
        self.title = title
        self.content = content
    }
}
