//
//  Trivia.swift
//  TrivaGame
//
//  Created by Pothapragada, Krishna N on 1/7/26.
//

import Foundation


struct Trivia {
    var q: String
    var correct: String
    var incorrect: [String]

    func shuffleAnswers() -> [String] {
        var all = incorrect + [correct]
        all.shuffle()
        return all
    }
}





