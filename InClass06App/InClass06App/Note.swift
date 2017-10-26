//
//  Note.swift
//  InClass06App
//
//  Created by Gupta, Nidhi on 10/21/17.
//  Copyright © 2017 Example. All rights reserved.
//

import Foundation
class Note{
    var noteText: String?
    var noteDate : String?
    var noteKey : String?
    init (noteText: String, noteDate: String, noteKey: String) {
        self.noteText = noteText
        self.noteDate = noteDate
        self.noteKey = noteKey
    }
}
