//
//  ViewController.swift
//  TicTacToe
//
//  Created by Pothapragada, Krishna N on 9/29/25.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet var Board: [UIButton]!
    var game = TicTacToe()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func NH(_ sender: UIButton) {
        let index = sender.tag
        if game.MakeAMove(at: index) {
                sender.setTitle(game.currentPlayerMark(), for: .normal)
                
                if let winner = game.checkWinner() {
                    let alert = UIAlertController(title: "\(winner) won!", message: "Do you want to play again?", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Play Again", style: .default, handler: { _ in
                        self.game.ResetGame()
                        }))
                    for button in self.Board {
                        button.setTitle("", for: .normal)
                    }
                    self.present(alert, animated: true)
                } else {
                    
                    if Board.allSatisfy({ ($0.title(for: .normal) ?? "").isEmpty == false }) {
                       
                        let alert = UIAlertController(title: "Draw!", message: "Nobody wins. Play again?", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "Play Again", style: .default, handler: { _ in
                            self.game.ResetGame()
                            for button in self.Board {
                                button.setTitle("", for: .normal)
                            }
                        }))
                        self.present(alert, animated: true)
                    }
                    else{
                        game.togglePlayer()
                    }
                    
                }
            }
    }
    @IBAction func ResetBoard(_ sender: Any) {
        for button in self.Board {
            button.setTitle("", for: .normal)
        }
        game.ResetGame()
    }
    
}

