//
//  ViewController.swift
//  Destiny
//
//  Created by Pothapragada, Krishna N on 9/15/25.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var MainStory: UILabel!
    
    @IBOutlet weak var LeftOption: UIButton!
    
    @IBOutlet weak var RightOption: UIButton!
    
    @IBOutlet weak var LoadingBar: UIProgressView!
    
    @IBOutlet weak var LoadingText: UILabel!
    
    @IBOutlet weak var ResetButton: UIButton!
    
    @IBOutlet var Screen: UIView!
    
    let LoadingTexts = ["1010001010...","Initalizing code base","finding terminal","Running simulation", "almost there...", "Creating a dark nebula","leaking IP address","Initiating a bitcoin mining operation"]
    
    var destiny: Destiny = Destiny()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        StartLoadingScreen()
    }
    
    func chooseNum(_ chooseNum: Int){
        let progress = destiny.choose(choiceNum: chooseNum)
        
        
        if progress{
            updateView()
        }
        else{
            reset()
        }
    }
    
    func reset(){
        destiny.reset();
        StartLoadingScreen()
    }
    
    @IBAction func Choice1Click(_ sender: Any) {
        chooseNum(1)
    }
    @IBAction func Choice2Click(_ sender: Any) {
        chooseNum(2)
    }
    
    func updateView(){

        MainStory.text = destiny.GetStoryText()
        LeftOption.setTitle(destiny.GetChoice1Text(), for: .normal)
        RightOption.setTitle(destiny.GetChoice2Text(), for: .normal)
    }
    
    @IBAction func ResetClick(_ sender: Any) {
        let alertReset = UIAlertController(title: "RESET", message: "Aye gng u wanna reset?", preferredStyle: .alert)
        let accept = UIAlertAction(title: "Yes brochanco ik what im doing", style: .destructive) { _ in
            self.reset()
        }
        let dismiss = UIAlertAction(title: "Sorry king I was just playing around", style: .default)
        alertReset.addAction(accept)
        alertReset.addAction(dismiss)
        
        self.present(alertReset, animated: true, completion: nil)
    }
    func StartLoadingScreen(){
        Screen.backgroundColor = .black
        // Do any additional setup after loading the view.
        MainStory.isHidden = true
        LeftOption.isHidden = true
        RightOption.isHidden = true
        LoadingBar.progress = 0.0
        LoadingBar.isHidden = false
        LoadingText.isHidden = false;
        LoadingText.textColor = .white
        ResetButton.isHidden = true
        
        
        var currentIndex = 0
        let totalDuration: TimeInterval = 20.0
        let interval: TimeInterval = 0.07
        
        let totalSteps = Int(totalDuration/interval)
        
        Timer.scheduledTimer(withTimeInterval: interval, repeats: true) { timer in
            if currentIndex < 100{
                self.LoadingText.text = self.LoadingTexts.randomElement()
            }
            let progress = Float(currentIndex+100) / Float(totalSteps)
            self.LoadingBar.setProgress(progress, animated: true)
            
            currentIndex += 1
            
            if currentIndex >= 100{
                timer.invalidate()
                self.MainStory.isHidden = false
                self.LeftOption.isHidden = false
                self.RightOption.isHidden = false
                self.LoadingBar.isHidden = true
                self.LoadingText.isHidden = true;
                self.Screen.backgroundColor = .white
                self.ResetButton.isHidden = false
                self.updateView()
                
            }
                
        }
        
    }

}

