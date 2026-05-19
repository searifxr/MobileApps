//
//  ViewController.swift
//  Ip 01
//
//  Created by Pothapragada, Krishna N on 8/28/25.
//

import UIKit

class ViewController: UIViewController {

    var Rich = true
    
    @IBOutlet weak var TextLabel: UILabel!
    @IBOutlet weak var RichImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        RichImage.image = UIImage(named: "Image")
        
    }
    
    @IBAction func ChangeScreen(_ sender: Any) {
        Rich.toggle()
        view.backgroundColor = Rich ? .systemBlue : .systemCyan
        
        TextLabel.text = Rich ? "I am rich" : "I am poor"
        
        RichImage.image = Rich ? UIImage(named: "Image") : UIImage(named: "Rock")
    }
    
}

