//
//  AddNote.swift
//  AgendApp
//
//  Created by Queralt Sosa Mompel on 26/3/18.
//  Copyright © 2018 Queralt Sosa Mompel. All rights reserved.
//

import UIKit
import FirebaseDatabase
import Firebase

class AddNote: UIViewController, UITextViewDelegate {
    var ref: FIRDatabaseReference!
    
    @IBOutlet weak var noteTitle: UITextField!
    @IBOutlet weak var content: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = FIRDatabase.database().reference()
        content.delegate = self
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        self.content.text = ""
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func addNote(_ sender: Any) {
        let dt = DateFormatter()
        dt.dateFormat = "dd-MM-yyyy"
        let dateString = dt.string(from: Date())
        
        let userID = FIRAuth.auth()?.currentUser!.uid
        

        let key = ref.childByAutoId().key
        

        let note = ["idUser":userID,
                    "date": dateString,
                    "title": noteTitle.text! as String,
                    "content": content.text! as String
        ]
        

        ref.child(key).setValue(note)
        
    }
    

    
    
    @IBAction func cancel(_ sender: Any) {
        noteTitle.text = ""
        content.text = ""
    }
    
}
