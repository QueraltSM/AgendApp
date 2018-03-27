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


class TableViewController: UITableViewController, UITableViewDelegate, UITableViewDataSource {
    
    var menu_vc : SideMenuVC!
    var items = [Note]()
    @IBOutlet var myTableView: UITableView!
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (section == 0) {
            return 1
        }
        return items.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if(indexPath.row > items.count-1){
            return UITableViewCell()
        }
        else{
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCellNotes
            
            let item = items[indexPath.row]
            print("ITEM EN CELL ROW = ", item.toString())
            cell.content?.text = item.toString()
            return cell
        }
    }
    
    func startObservingDatabase () {
        var newItems = [Note]()
        _ = FIRDatabase.database().reference().observeSingleEvent(of: .value, with: { snapshot in
            
            for rest in snapshot.children.allObjects as! [FIRDataSnapshot] {
                for note in rest.children.allObjects as! [FIRDataSnapshot] {
                    
                    let title = note.childSnapshot(forPath: "title").value
                    let date = note.childSnapshot(forPath: "date").value
                    let content = note.childSnapshot(forPath: "content").value
                    
                    newItems.append(Note(date: date as! String, title: title as! String, content: content as! String))
                }
            }
            self.items = newItems
            
        })
        self.myTableView.reloadData()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myTableView.dataSource = self as UITableViewDataSource
        myTableView.delegate = self as UITableViewDelegate
        
        startObservingDatabase()
        
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
    
    func toString() -> String {
        let s = self.date + "\n" + self.title + "\n" + self.content
        return s
    }
}

