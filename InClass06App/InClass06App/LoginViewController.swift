//
//  LoginViewController.swift
//  InClass06App
//
//  Created by Gupta, Nidhi on 10/20/17.
//  Copyright © 2017 Example. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {

    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    var loggedInUserEmail = ""
    
    override func viewDidAppear(_ animated: Bool) {
        if let _ = Auth.auth().currentUser {
            print("already logged in")
            // loggedInUserEmail = (Auth.auth().currentUser?.email!)!
            self.signIn()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnLogin(_ sender: Any) {
       let email = txtEmail.text!
       let password = txtPassword.text!
        if(email.isEmpty || password.isEmpty)
        {
             showAlert("Email or Password not entered.")
        }
        else
        {
            Auth.auth().signIn(withEmail: email, password: password, completion: { (user, error) in
                if user == nil {
                    if let error = error {
                        if let errCode = AuthErrorCode(rawValue: error._code) {
                            switch errCode {
                            case AuthErrorCode.userNotFound:
                                self.showAlert("User account not found. Try registering")
                            case AuthErrorCode.wrongPassword:
                                self.showAlert("Incorrect username/password combination")
                            default:
                                self.showAlert("Error: \(error.localizedDescription)")
                            }
                        }
                        return
                    }
                }else{
                    //self.loggedInUserEmail = (user?.email!)!
                    self.signIn()
                }
            })
        }
    }
    func showAlert(_ message: String) {
        let alertController = UIAlertController(title: "Login Failed", message: message, preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
    
   func signIn() {
    let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
    let navController = storyBoard.instantiateViewController(withIdentifier: "navController") as! UINavigationController
    let notebookVC = self.storyboard!.instantiateViewController(withIdentifier: "notebookVC") as! NoteBookTableViewController
     //notebookVC.userEmail = loggedInUserEmail
    self.present(navController, animated: false, completion: {
        navController.pushViewController(notebookVC, animated: false)
    })
   }
 }




