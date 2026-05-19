//
//  WordleBackend.swift
//  Wordle
//
//  Created by Pothapragada, Krishna N on 4/1/26.
//

import Foundation
import SwiftUICore

struct Tile{
    var letter: String
    var color: TileColor
}

enum TileColor {
    case gray
    case yellow
    case green
}

class WordleBackend: ObservableObject {
    @Published var currentWord: String = ""
    @Published var guesses: [[Tile]] = []
    @Published var currentInput: String = ""
    @Published var currentRow: Int = 0
    @Published var gameOver: Bool = false
    
    var validWords: [String] = []
    var solutionWords: [String] = []
    
    @Published var DidWin: Bool = false
    
    func loadWords() {
        if let taPath = Bundle.main.path(forResource: "wordle-Ta", ofType: "txt"),
           let laPath = Bundle.main.path(forResource: "wordle-La", ofType: "txt") {
            
            let taContent = try? String(contentsOfFile: taPath, encoding: .utf8)
            let laContent = try? String(contentsOfFile: laPath, encoding: .utf8)
            
            validWords = taContent?
                .components(separatedBy: .newlines)
                .map { $0.trimmingCharacters(in: .whitespacesAndNewlines).lowercased() }
                .filter { !$0.isEmpty } ?? []
            solutionWords = laContent?.components(separatedBy: "\n") ?? []
        }
    }
    
    func pickWord() {
        currentWord = solutionWords.randomElement() ?? "apple"
    }
    
    func addLetter(_ letter: String) {
        if currentInput.count < 5 && !gameOver {
            currentInput += letter.lowercased()
        }
    }
    
    func removeLetter() {
        if !currentInput.isEmpty && !gameOver {
            currentInput.removeLast()
        }
    }
    
    func submitGuess() {
        let guess = currentInput.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)

        
        print("INPUT:", currentInput)
        print("LOWER:", currentInput.lowercased())
        print("EXISTS:", validWords.contains(currentInput.lowercased()))
        print("CORRECT WORD:", currentWord)
        
        if validWords.contains(guess) || solutionWords.contains(guess) {
          
          
            var tiles: [Tile] = []
            var answer = Array(currentWord)
            
            for(i, char) in guess.enumerated(){
                if char == answer[i]{
                    tiles.append(Tile(letter: String(char), color: .green))
                    answer[i] = "*"
                }
                else{
                    tiles.append(Tile(letter: String(char), color: .gray))
                }
            }
            
            for i in 0..<tiles.count{
                if tiles[i].color == .gray,
                    let index = answer.firstIndex(of: Character(tiles[i].letter)) {
                        tiles[i].color = .yellow
                        answer[index] = "*"
                    }
                
            }
            
            guesses.append(tiles)
            
            if guess == currentWord {
                gameOver = true
                DidWin = true
            }
            
            currentInput = ""
            currentRow += 1
            
            if currentRow == 6 && !(guess == currentWord) {
                gameOver = true
                DidWin = false
            }
        }
        
        print("Game Over or not? ", gameOver)
    }
    
    func reset(){
    currentWord = ""
    guesses = []
         currentInput = ""
    currentRow = 0
          gameOver = false
        
         validWords = []
        solutionWords = []
        
        DidWin = false
        pickWord()
    }
}
