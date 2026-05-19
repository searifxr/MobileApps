//
//  GameTabBarController.swift
//  TrivaGame
//
//  Created by Pothapragada, Krishna N on 1/7/26.
//

import Foundation
import UIKit

struct GameConfig {
    var category: String
    var numberOfQuestions: Int
    var questions: [Trivia]
    var currentIndex: Int
    var correctCount: Int
    var score: Int
    var currentStreak: Int
    var maxStreak: Int
}

class GameTabBarController: UITabBarController {
    let questionDB = TriviaGame.getQuestionDB()
    var currentGame: GameConfig?
}

