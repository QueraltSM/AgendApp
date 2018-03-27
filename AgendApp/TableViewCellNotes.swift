//
//  TableViewCell.swift
//  AgendApp
//
//  Created by Queralt Sosa Mompel on 26/3/18.
//  Copyright © 2018 Queralt Sosa Mompel. All rights reserved.
//

import UIKit
import Firebase

class TableViewCellNotes: UITableViewCell {
    
    @IBOutlet var title: UILabel!
    @IBOutlet var date: UILabel!
    @IBOutlet var content: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func deleteNote(_ sender: Any) {
    }
    
    
    @IBAction func modifyNote(_ sender: Any) {
    }
    
    
    @IBAction func shareNote(_ sender: Any) {
    }
    
    
}

