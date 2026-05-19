//
//  ViewController.swift
//  InterfaceBuilderBasics
//
//  Created by Pothapragada, Krishna N on 8/26/25.
//

import UIKit

class ViewController: UIViewController {


    
    var lightOn = true
    override func viewDidLoad() {
        super.viewDidLoad()
        ChangeBGcolor()
        // Do any additional setup after loading the view.
    }

    fileprivate func ChangeBGcolor() {
        if lightOn {
            view.backgroundColor = .white
            
        }
        else {
            view.backgroundColor = .black
        
        }
    }
    
    @IBAction func ButtonPress(_ sender: Any) {
        lightOn.toggle()
        ChangeBGcolor()
    }
    
}

