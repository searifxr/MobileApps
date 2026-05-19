//
//  ViewController.swift
//  Xylophone
//
//  Created by Pothapragada, Krishna N on 10/21/25.
//

import UIKit
import AVFoundation
class ViewController: UIViewController {

    var player: AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func KeyPressed(_ sender: UIButton!) {
        switch sender.tag {
        case 0:
            playSounda("C")
            break
        case 1:
            playSounda("D")
            break
        case 2:
            playSounda("E")
            break
        case 3:
            playSounda("F")
            break
        case 4:
            playSounda("G")
            break
        case 5:
            playSounda("A")
            break
        case 6:
            playSounda("B")
            break
        case 7:
            playSounda("C")
        default:
            print("you didn't press anything")
        }
    }
    
    func playSounda(_ note: String){
        let url = Bundle.main.url(forResource: note, withExtension: "wav")
        player = try! AVAudioPlayer(contentsOf: url!)
        player.play()
    }

}

