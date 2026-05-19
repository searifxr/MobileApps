//
//  HomePageController.swift
//  Voluntracker
//
//  Created by Pothapragada, Krishna N on 12/1/25.
//

import UIKit

class HomePageController: UIViewController {

    @IBOutlet var HoursWishing: UILabel!
    var number = 1

    @IBOutlet var welcomeMessage: UILabel!
    var username: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        welcomeMessage.text = "Welcome, \(username)"
        // Do any additional setup after loading the view.
    }
    
    @IBAction func AddOrSubtractHours(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            if number == 0
            {
                number = 0
            }
            else {
                number -= 1
            }
        default:
            number += 1
        }
        
        if let text = HoursWishing.text, !text.isEmpty {
            let rest = text.drop(while: { $0.isNumber })
            HoursWishing.text = "\(number)\(rest)"
        }
    }
    
    @IBAction func Continue(_ sender: Any) {
        performSegue(withIdentifier: "CompleteHoursController", sender: number)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dest = segue.destination as? CompleteHoursController,
           let hoursTotal = sender as? Int {
            dest.totalHours = hoursTotal
        }
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
