//
//  ViewController.swift
//  RGBmatcher
//
//  Created by Pothapragada, Krishna N on 10/15/25.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var InputColor: UILabel!
    
    @IBOutlet weak var MatchColor: UILabel!
    
    @IBOutlet weak var TimeLabel: UILabel!
    
    @IBOutlet weak var RedSlider: UISlider!
    
    @IBOutlet weak var GreenSlider: UISlider!
    
    @IBOutlet weak var BlueSlider: UISlider!
    
    var RGB_Red: Double = 0
    var RGB_Green: Double = 0
    var RGB_Blue: Double = 0
    
    var InputRed: Double = 0
    var InputGreen: Double = 0
    var InputBlue: Double = 0
    
    var hasWon:Bool = false
    
    var timer: Timer?
    var timeRemaining = 30
    
    var rDiff: Double = 0
    var gDiff: Double = 0
    var bDiff: Double = 0
    var diff: Double = 0
    var rawScore: Double = 0
    var score: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        InputColor.layer.borderWidth = 2
        MatchColor.layer.borderWidth = 2
        
        setupGame()
    }
    
    func setupGame(){
        RGB_Red = Double.random(in: 0.0..<1.0)
        RGB_Green = Double.random(in: 0.0..<1.0)
        RGB_Blue = Double.random(in: 0.0..<1.0)
        
        InputRed = 0
        InputBlue = 0
        InputGreen = 0
        
        RedSlider.value = 0
        GreenSlider.value = 0
        BlueSlider.value = 0
        
        InputColor.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        MatchColor.backgroundColor = UIColor(red: RGB_Red, green: RGB_Green, blue: RGB_Blue, alpha: 1)
        hasWon = false
            timeRemaining = 30
            TimeLabel.text = "Time: \(timeRemaining)s"
            
            timer?.invalidate()
            startTimer()
    }
    @IBAction func ColorSwitch(_ sender: UISlider) {
        switch sender.tag {
        case 0:
            InputRed = Double(sender.value)
        case 1:
            InputGreen = Double(sender.value)
        case 2:
            InputBlue = Double(sender.value)
        default:
            print("Bru what u click gng 😭")
        }
        
        InputColor.backgroundColor = UIColor(red: InputRed, green: InputGreen, blue: InputBlue, alpha: 1)
        
        
    }
    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }

    @objc func updateTimer() {
        timeRemaining -= 1
        TimeLabel.text = "\(timeRemaining)"

         rDiff = RGB_Red - InputRed
        gDiff = RGB_Green - InputGreen
        bDiff = RGB_Blue - InputBlue
        diff = sqrt(rDiff*rDiff+gDiff*gDiff+bDiff*bDiff)
        rawScore = (1.0-diff) * 100.0
        score = Int(round(rawScore))
        
        CheckWinner()

        if hasWon {
            timer?.invalidate()
            endGame()
        } else if timeRemaining <= 0 {
            timer?.invalidate()
            endGame()
        }
    }

    func CheckWinner(){
        if score > 90{
            hasWon = true
        }
    }
    
    func endGame() {
        CheckWinner()
        
        if hasWon {
            let alert = UIAlertController(title: "Congratulations!",
                                          message: "You matched the colors!",
                                          preferredStyle: .alert)
            
            let okAction = UIAlertAction(title: "OK", style: .default) { _ in
               
                self.setupGame()
            }
            
            alert.addAction(okAction)
            
            
            self.present(alert, animated: true, completion: nil)
        }
        let alert = UIAlertController(title: "Too bad!",
                                      message: "Your score: \(score)",
                                      preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "I was so close", style: .default) { _ in
           
            self.setupGame()
        }
        
        alert.addAction(okAction)
        
        
        self.present(alert, animated: true, completion: nil)
    }

    

}

