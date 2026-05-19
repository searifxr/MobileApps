//
//  ViewController.swift
//  LearningXcode2
//
//  Created by Pothapragada, Krishna N on 8/26/25.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var FirstButton: UIButton!
    @IBOutlet var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        FirstButton.tintColor = .red
        scrollView.contentSize = CGSize(width: 100, height: 100)
        let label = UILabel(frame: <#T##CGRect#>(x:16, y:16, width: 200, height: 400))
        
    }


    @IBAction func Button(_ sender: Any) {
        print("Pressed!")
    }
}

