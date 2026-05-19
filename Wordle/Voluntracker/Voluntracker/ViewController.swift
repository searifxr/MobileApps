//
//  ViewController.swift
//  Voluntracker
//
//  Created by Pothapragada, Krishna N on 11/20/25.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet var usernameField: UITextField!
    
    @IBOutlet var passwordField: UITextField!
    
    var storedName = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    @IBAction func loginPressed(_ sender: UIButton) {
        let storedUsername = UserDefaults.standard.string(forKey: "username")
        let storedPassword = UserDefaults.standard.string(forKey: "pwd")
        let storeduser = UserDefaults.standard.string(forKey: "user")
        let enteredUser = usernameField.text ?? ""
        let enteredPwd = passwordField.text ?? ""

        if enteredUser == storedUsername && enteredPwd == storedPassword {
            print("Login successful!")
            performSegue(withIdentifier: "HomePageController", sender: storeduser)
        } else {
            print("Invalid username or password")
            return
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dest = segue.destination as? HomePageController,
           let username = sender as? String {
            dest.username = username
        }
    }
    


}

