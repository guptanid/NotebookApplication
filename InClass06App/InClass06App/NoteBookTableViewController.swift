//
//  NoteBookTableViewController.swift
//  InClass06App
//
//  Created by Gupta, Nidhi on 10/20/17.
//  Copyright © 2017 Example. All rights reserved.
//

import UIKit
import Firebase

class NoteBookTableViewController: UITableViewController {
  //$(PRODUCT_NAME)
    //com.example.InClass06App
    //var userEmail = ""
    var userID: String = ""
    var notebooks:[NoteBook] = []
    var ref: DatabaseReference!
   
   
    override func viewDidLoad() {
        super.viewDidLoad()
        userID = (Auth.auth().currentUser?.uid)!
        ref = Database.database().reference()
        GetAllNoteBooksForUser()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       return 100
   }
    override func numberOfSections(in tableView: UITableView) -> Int {
       return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.notebooks.count
    }
   override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "notebookCell", for: indexPath) as! NoteBookTableViewCell
        let notebook =  notebooks[indexPath.item]
        cell.txtNoteBookName.text = notebook.notebookName
        cell.txtCreatedOn.text = notebook.notebookCreatedOn
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let notebook = notebooks[indexPath.item]
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let navController = storyBoard.instantiateViewController(withIdentifier: "navController") as! UINavigationController
        let notesVC = self.storyboard!.instantiateViewController(withIdentifier: "notesVC") as! NotesTableViewController
        notesVC.notebookKey = notebook.key!
        self.present(navController, animated: false, completion: {
            navController.pushViewController(notesVC, animated: true)
        })
    }
    @IBAction func LogOut_Clicked(_ sender: Any) {
        print("logout")
        try! Auth.auth().signOut()
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let loginViewController = storyBoard.instantiateViewController(withIdentifier: "loginViewController") as! LoginViewController
        self.present(loginViewController, animated: true, completion: nil)
    }
    
    @IBAction func AddNewNoteBook_Clicked(_ sender: Any) {
        let addNotebookAlertController = UIAlertController(title: "New Notebook", message: "Enter Notebook Name", preferredStyle: UIAlertControllerStyle.alert)
        addNotebookAlertController.addTextField { (notebookTextField: UITextField) in
            notebookTextField.placeholder = "Notebook Name"
        }
        let actionOK = UIAlertAction(title: "OK", style: .default) { (alertAction:UIAlertAction) in
            let notebookTextField = addNotebookAlertController.textFields![0] as UITextField
            if let notebookName = notebookTextField.text{
                if !notebookName.isEmpty{
                    let createdOnDate = DateFormatter.localizedString(from: Date(), dateStyle: .medium, timeStyle: .short)
                    let notebookRef = self.ref.child("Notebooks").child(self.userID).childByAutoId()
                    let newNotebook = [
                        "notebookName" : notebookName,
                        "createdOnDate" : createdOnDate
                    ]
                    notebookRef.setValue(newNotebook)
                    self.GetAllNoteBooksForUser()
                }
            }
        }
        let actionCancel = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        addNotebookAlertController.addAction(actionOK)
        addNotebookAlertController.addAction(actionCancel)
        self.navigationController?.present(addNotebookAlertController, animated: true, completion: nil)
    }
    func GetAllNoteBooksForUser() {
        let userNotebookRef = self.ref.child("Notebooks").child(self.userID)
        userNotebookRef.observeSingleEvent(of: DataEventType.value) { (snapshot) in
            if let notebooks = snapshot.value as? NSDictionary{
                self.notebooks.removeAll()
                for notebook in notebooks {
                    let notebookKey = notebook.key as! String
                    let object = notebook.value as? [String:Any]
                    let notebookName = object!["notebookName"] as! String
                    let createdOnDate = object!["createdOnDate"] as! String
                    let notebook = NoteBook(notebookName: notebookName, createdOn: createdOnDate, notebookKey: notebookKey)
                    self.notebooks.append(notebook)
                }
                self.tableView.reloadData()
            }
        }
    }
    
}

