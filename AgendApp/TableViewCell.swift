//
//  TableViewCell.swift
//  AgendApp
//
//  Created by Queralt Sosa Mompel on 26/3/18.
//  Copyright © 2018 Queralt Sosa Mompel. All rights reserved.
//

import UIKit
import Firebase

class TableViewCell: UITableViewCell {

    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var content: UITextField!
    
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
