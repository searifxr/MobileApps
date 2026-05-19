import UIKit

class QuestionsViewController: UIViewController {

    @IBOutlet weak var Question: UILabel!
    
    @IBOutlet var Choices: [UIButton]!
    
    
    @IBOutlet weak var Progress: UIProgressView!
    
    var currentAnswers: [String] = []


    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Progress.setProgress(0, animated: false)
        loadQuestion()
    }

    private func loadQuestion() {

            guard
                let tabBar = tabBarController as? GameTabBarController,
                let game = tabBar.currentGame
            else {
                Question.text = "No game loaded"
                return
            }
        
        if(game.currentIndex >= game.questions.count){
            Progress.setProgress(1.0, animated: true)
            Question.text = "Game Over. Score: \(game.score)"
                    for button in Choices {
                        button.isEnabled = false
                        button.setTitle("", for: .normal)
                    }
                    return
        }

            let trivia = game.questions[game.currentIndex]
            Question.text = trivia.q

            currentAnswers = trivia.shuffleAnswers()


            for button in Choices {
                let index = button.tag
                guard index < currentAnswers.count else { continue }

                button.setTitle(currentAnswers[index], for: .normal)
                button.isEnabled = true
            }
        }

        @IBAction func choiceTapped(_ sender: UIButton) {

            guard
                let tabBar = tabBarController as? GameTabBarController,
                var game = tabBar.currentGame
            else { return }

            
            let trivia = game.questions[game.currentIndex]
            
            let selectedAnswer = currentAnswers[sender.tag]
            
            if selectedAnswer == trivia.correct {
                game.correctCount += 1
                game.currentStreak += 1
                game.maxStreak = max(game.maxStreak, game.currentStreak)
                game.score += 10
                
            } else {
                game.currentStreak = 0
            }
            
            for button in Choices {
                    button.isEnabled = false
                }

            game.currentIndex += 1
            
            Progress.setProgress(Float(game.currentIndex) / Float(game.questions.count), animated: false)
            tabBar.currentGame = game

            currentAnswers = trivia.shuffleAnswers()
            
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.loadQuestion()
            }
        }
}
