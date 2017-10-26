//
//  NoteBook.swift
//  InClass06App
//
//  Created by Gupta, Nidhi on 10/21/17.
//  Copyright © 2017 Example. All rights reserved.
//

import Foundation
class NoteBook{
    var notebookName: String?
    var notebookCreatedOn : String?
    var key : String?
    init (notebookName: String, createdOn: String, notebookKey: String) {
     self.notebookName = notebookName
     self.notebookCreatedOn = createdOn
     self.key = notebookKey
    }

}
