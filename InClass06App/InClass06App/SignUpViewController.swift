//
//  SignUpViewController.swift
//  InClass06App
//
//  Created by Gupta, Nidhi on 10/20/17.
//  Copyright © 2017 Example. All rights reserved.
//

import UIKit
import Firebase

class SignUpViewController: UIViewController {

    var userName = "", email = "", password = ""
    var baseRef: DatabaseReference!
    
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtConfirmPassword: UITextField!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        baseRef = Database.database().reference()
      
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnSubmit(_ sender: Any) {
        if(txtName.text == "" || txtEmail.text == "" || txtPassword.text == "" || txtConfirmPassword.text == ""){
           showAlert("Enter all details.")
        }
        else if(txtPassword.text != txtConfirmPassword.text){
             showAlert("Passwords don't match.")
        }
        else {
            userName = txtName.text!
            email = txtEmail.text!
            password = txtPassword.text!
           
                Auth.auth().createUser(withEmail: self.email, password: self.password, completion: { (user, error) in
                    if error != nil {
                        self.showAlert(error!.localizedDescription)
                    }
                    else {
                        Auth.auth().signIn(withEmail: self.email, password: self.password, completion: { (user, error) in
                            self.signIn()
                    })
                   }
                })
            }
        }
    func showAlert(_ message: String) {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
    func signIn() {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let navController = storyBoard.instantiateViewController(withIdentifier: "navController") as! UINavigationController
        let notebookVC = self.storyboard!.instantiateViewController(withIdentifier: "notebookVC") as! NoteBookTableViewController
       // notebookVC.userEmail = txtEmail.text!
        self.present(navController, animated: false, completion: {
            navController.pushViewController(notebookVC, animated: false)
        })
    }

}
