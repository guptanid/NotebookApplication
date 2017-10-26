//
//  NotesTableViewController.swift
//  InClass06App
//
//  Created by Gupta, Nidhi on 10/20/17.
//  Copyright © 2017 Example. All rights reserved.
//

import UIKit
import Firebase

class NotesTableViewController: UITableViewController {

    var notebookKey:String = ""
    var ref : DatabaseReference!
    var notes:[Note] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        GetAllNotes()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
      return  200
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
   override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "noteCell", for: indexPath) as! NotesTableViewCell

        cell.txtNotesDescription.text = notes[indexPath.item].noteText
        cell.txtCreatedOn.text = notes[indexPath.item].noteDate
        cell.btnDeleteCell.tag = indexPath.item
        return cell
    }
    
    @IBAction func AddNewNote_Clicked(_ sender: Any) {
        let addNoteAlertController = UIAlertController(title: "New Note", message: "Enter New Post Text", preferredStyle: UIAlertControllerStyle.alert)
        addNoteAlertController.addTextField { (noteTextField: UITextField) in
            noteTextField.placeholder = "Note text"
        }
        let actionOK = UIAlertAction(title: "OK", style: .default) { (alertAction:UIAlertAction) in
            let noteTextField = addNoteAlertController.textFields![0] as UITextField
            if let notesText = noteTextField.text{
                if !notesText.isEmpty{
                    let noteDate = DateFormatter.localizedString(from: Date(), dateStyle: .medium, timeStyle: .short)
                    let noteRef = self.ref.child("Notes").child(self.notebookKey).childByAutoId();
                    let newNote = [
                        "noteText" : notesText,
                        "noteCreatedOn" : noteDate
                    ]
                    noteRef.setValue(newNote)
                    self.GetAllNotes()
                }
            }
        }
        let actionCancel = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        addNoteAlertController.addAction(actionOK)
        addNoteAlertController.addAction(actionCancel)
        self.navigationController?.present(addNoteAlertController, animated: true, completion: nil)
    }
   
    @IBAction func DeleteNote_Clicked(_ sender: Any) {
        let noteToDelete = notes[(sender as AnyObject).tag]
        let noteRef = self.ref.child("Notes").child(self.notebookKey).child(noteToDelete.noteKey!)
        noteRef.removeValue()
        notes.remove(at: (sender as AnyObject).tag)
        self.GetAllNotes()
    }
    
    func GetAllNotes(){
        let notesRef = self.ref.child("Notes").child(self.notebookKey)
        notesRef.observeSingleEvent(of: DataEventType.value) { (snapshot) in
            if let allUserNotes = snapshot.value as? NSDictionary{
                self.notes.removeAll()
                for note in allUserNotes {
                    let key = note.key as! String
                    let objNote = note.value as? [String:Any]
                    let noteText = objNote!["noteText"] as! String
                    let noteDate = objNote!["noteCreatedOn"] as! String
                    let note = Note(noteText: noteText, noteDate: noteDate, noteKey: key)
                    self.notes.append(note)
                }
            }
            self.tableView.reloadData()
        }
    }
}
