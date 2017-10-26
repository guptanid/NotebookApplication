//
//  NoteBookTableViewCell.swift
//  InClass06App
//
//  Created by Gupta, Nidhi on 10/20/17.
//  Copyright © 2017 Example. All rights reserved.
//

import UIKit

class NoteBookTableViewCell: UITableViewCell {

    @IBOutlet weak var txtNoteBookName: UILabel!
    @IBOutlet weak var lblCreatedOn: UILabel!
    @IBOutlet weak var txtCreatedOn: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        lblCreatedOn.text = "Created On:"
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
