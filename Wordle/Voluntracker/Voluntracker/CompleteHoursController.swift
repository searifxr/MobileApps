//
//  CompleteHoursController.swift
//  Voluntracker
//
//  Created by Pothapragada, Krishna N on 12/3/25.
//

import UIKit

class CompleteHoursController: UIViewController {

    @IBOutlet weak var HoursLabel: UILabel!
    var totalHours = 0
    var numbercompleted = 0
    override func viewDidLoad() {
        super.viewDidLoad()

        HoursLabel.text = "\(numbercompleted) hours out of \(totalHours)"
        // Do any additional setup after loading the view.
    }
    
    @IBAction func addingHours(_ sender: UITextField) {
        numbercompleted += Int(sender.text ?? "0") ?? 0
        HoursLabel.text = "\(numbercompleted) hours out of \(totalHours)"
        sender.text = ""
        checkifHoursisCompleted()
    }
    
    func checkifHoursisCompleted() {
        if(numbercompleted >= totalHours){
            let alert = UIAlertController(title: "Congrats", message: "You have reached or already passed your goal of \(totalHours) hour(s)!", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                
                self.present(alert, animated: true, completion: nil)
        }
        else {
            
            return
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
