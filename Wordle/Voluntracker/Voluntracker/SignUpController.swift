//
//  SignUpController.swift
//  Voluntracker
//
//  Created by Pothapragada, Krishna N on 11/20/25.
//

import UIKit

class SignUpController: UIViewController {

    let defaults = UserDefaults.standard
        
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
 

    @IBOutlet weak var user: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        // Do any additional setup after loading the view.
    }
    @IBAction func signUpPressed(_ sender: UIButton) {
        let username = usernameField.text ?? ""
        let pwd = passwordField.text ?? ""
        let user = user.text ?? ""
        if username.isEmpty || pwd.isEmpty || username.isEmpty {
            print("Fields cannot be empty")
            return
        }

        // Save to UserDefaults
        defaults.set(username, forKey: "username")
        defaults.set(pwd, forKey: "pwd")
        defaults.set(user, forKey: "user")

        print("Account created")
        performSegue(withIdentifier: "HomePageController", sender: user)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dest = segue.destination as? HomePageController,
           let username = sender as? String {
            dest.username = username
        }
    }

    
}
