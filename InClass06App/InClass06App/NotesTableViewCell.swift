//
//  NotesTableViewCell.swift
//  InClass06App
//
//  Created by Gupta, Nidhi on 10/20/17.
//  Copyright © 2017 Example. All rights reserved.
//

import UIKit

class NotesTableViewCell: UITableViewCell {

    @IBOutlet weak var txtNotesDescription: UILabel!
    @IBOutlet weak var lblCreatedOn: UILabel!
    @IBOutlet weak var txtCreatedOn: UILabel!
   
    @IBOutlet weak var btnDeleteCell: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        lblCreatedOn.text = "Created On:"
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func btnDeleteNote(_ sender: Any) {
    }
}
