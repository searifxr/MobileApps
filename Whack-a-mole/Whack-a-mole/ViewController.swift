import UIKit

class ViewController: UIViewController {
    
    var screenWidth  = 0
    var screenHeight = 0

//    var lblHorizontal = UILabel() // Create a label object (has no position / size yet)
//    var lblVertical   = UILabel()
    
    var lblSocre = UILabel()
    var score = 0 {
        didSet{
            lblSocre.text = "Score: \(score)"
        }
    }
    var lblBackground = UILabel()
    var mole = UIButton()
    var StartButton = UIButton()
    var timer = Timer()
    var totalGameTime = 60
    var totalTimeRemaining = 60
    var gameTimer = Timer()
    var gameTimerLabel = UILabel()
    override func viewDidLoad() { // This function is called when the screen loads
        super.viewDidLoad() // Call super-class' method, you can leave this here

        // Do any additional setup after loading the view.

        let screenBounds: CGRect = UIScreen.main.bounds // Get the rectangle object with size of screen
        screenWidth  = Int(screenBounds.width)          // Make variable for rectangle's width property
        screenHeight = Int(screenBounds.height)         // Make variable for rectangle's height property
        
        print("Screen width = \(screenWidth), screen height = \(screenHeight)")
        
        // Horizontal label, full screen width
        // A view's frame is its bounding box, defined by a rectangle object
//        lblHorizontal.frame = CGRect(x: 20, y: 100, width: screenWidth - 40, height: 50)
//        lblHorizontal.backgroundColor = UIColor.blue
//        lblHorizontal.text = "Screen width: \(screenWidth), Label width: \(screenWidth - 40)"
//        
//// The 'view' property is a reference to the "parent" view that contains all the sub (child) views
////   this is inherited from the UIViewController class
//        view.addSubview(lblHorizontal)
        /// Add the view to the screen
//
//        // Vertical label, full screen height
//        lblVertical.frame = CGRect(x: 50, y: 20, width: 50, height: screenHeight - 40)
//        lblVertical.backgroundColor = UIColor.red
//        lblVertical.text = "Screen height: \(screenHeight), Label height: \(screenHeight - 40)"
//        lblVertical.transform = CGAffineTransform(rotationAngle: .pi / 2.0) // Rotate the label
//        
//        view.addSubview(lblVertical)
        
        /// Width = 402, Height = 874
        
        setupBoard()
        
    }
    func setupBoard(){
        StartButton.frame = CGRect(x: CGFloat(screenWidth - (screenWidth/2 + 50)), y: CGFloat(screenHeight - (screenHeight - 50)), width: 150, height: CGFloat(screenHeight / 25))
        StartButton.setTitle("Start", for: .normal)
        StartButton.backgroundColor = .brown
        StartButton.layer.cornerRadius = 15
        StartButton.addTarget(self, action: #selector(Start), for: .touchUpInside)
        view.addSubview(StartButton)
        
        lblSocre.frame = CGRect(x: CGFloat(screenWidth - (screenWidth - 30)), y: CGFloat(screenHeight - (screenHeight - 30)), width: 100, height: CGFloat(screenHeight / 10))
        lblSocre.text = "Score: \(score)"
        view.addSubview(lblSocre)
        
        let yPosition = lblSocre.frame.origin.y + lblSocre.frame.height - 30
        lblBackground.frame = CGRect(x: 0, y: Int(yPosition), width: screenWidth, height: screenHeight - 30)
        lblBackground.backgroundColor = .green
        view.addSubview(lblBackground)
        
        let moleSize: CGFloat = 40
        let x = CGFloat(Int.random(in: 0..<Int(lblBackground.bounds.width)-Int(mole.frame.width)))
        let y = CGFloat(Int.random(in: 0..<Int(lblBackground.bounds.height)-Int(mole.frame.height)))
        mole.frame = CGRect(x: x, y: y, width: moleSize, height: moleSize)
        mole.layer.cornerRadius = 20
//        mole.layer.masksToBounds = true
        mole.backgroundColor = .brown
        mole.addTarget(self, action: #selector(MoleTapped), for: .touchUpInside)
        view.addSubview(mole)
        
        gameTimerLabel.frame = CGRect(x: CGFloat(screenWidth - (screenWidth/2 + 50)), y: CGFloat(screenHeight - (screenHeight - 50)), width: 25, height: CGFloat(screenHeight / 25))
        gameTimerLabel.text = "\(totalTimeRemaining)"
        view.addSubview(gameTimerLabel)
        
        mole.isHidden = true
        gameTimerLabel.isHidden = true
        
        
        
        
    }
    
  
    func hitMole(){
        lblBackground.layoutIfNeeded()

            let moleSize: CGFloat = 40
            let maxX = lblBackground.frame.width - moleSize
            let maxY = lblBackground.frame.height - moleSize

            let x = CGFloat.random(in: 0..<max(1, maxX))
            let y = CGFloat.random(in: 0..<max(1, maxY))

            mole.frame = CGRect(x: x, y: y + lblBackground.frame.origin.y, width: moleSize, height: moleSize)
    }
    
    @objc
    func Start(){
        mole.isHidden = false
        StartButton.isHidden = true
        gameTimerLabel.isHidden = false
        totalTimeRemaining = totalGameTime
        startMoleTimer()
        StartGameTimer()

    }
    
    @objc func TimerFired(){
        hitMole()
        startMoleTimer()
    }
    
    @objc
    func MoleTapped(){
        score += 1
        hitMole()
        startMoleTimer()
    }
    

    func startMoleTimer(){
        timer.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 0.9, target: self,                                 selector: #selector(TimerFired), userInfo: nil, repeats: false)
    }
    
    func StartGameTimer(){
        gameTimer.invalidate()
        gameTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateGameTimer), userInfo: nil, repeats: true)
    }
    
    @objc func updateGameTimer(){
        totalTimeRemaining -= 1
        updateTimeLabel()
        
        if totalTimeRemaining <= 0{
            endGame()
        }
    }
    
    func updateTimeLabel(){
        gameTimerLabel.text = "\(totalTimeRemaining)"
    }
    
    func endGame(){
        gameTimer.invalidate()
            timer.invalidate()
            mole.isHidden = true

            // Optional: show final score
            let alert = UIAlertController(title: "Game Over", message: "Your score: \(score)", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                self.StartButton.isHidden = false
                self.score = 0
                self.updateTimeLabel()
            }))
            present(alert, animated: true, completion: nil)
        gameTimerLabel.isHidden = true
    }
}
