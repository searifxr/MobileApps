//
//  WarGame.swift
//  War_SwiftUI
//
//  Created by BUNN, BRYAN on 8/6/24.
//

import Foundation 
import SwiftUI

class WarGame: ObservableObject {
    
    @Published var playerDeck    : [Card] = []
    @Published var opponentDeck  : [Card] = []
    @Published var playerCard    : Card?
    @Published var opponentCard  : Card?
    @Published var gameOver      : Bool = false
    @Published var winner        : String?
    @Published var isWarHappening: Bool = false
    
    private var playerWarCards  : [Card] = [] //stores the face down cards in the case of a war
    private var opponentWarCards: [Card] = []

    init() {
        startNewGame()
    }

    ///call to reset the game to the beginning state
    func startNewGame() {
        var deck = createDeck()
        
        deck.shuffle()
        
        let middleIndex = deck.count / 2
        
        playerDeck    = Array(deck[..<middleIndex])
        opponentDeck  = Array(deck[middleIndex...])
        gameOver      = false
        winner        = nil
        playerCard    = nil
        opponentCard  = nil
    }

    ///create all the cards
    private func createDeck() -> [Card] {
        var deck: [Card] = []
        
        for suit in Suit.allCases {
            for rank in Rank.allCases {
                deck.append(Card(suit: suit, rank: rank))
            }
        }
        return deck
    }

    ///call to place two cards (one from each 'player') face up and calculate the result
    func drawCards() {
        guard !playerDeck.isEmpty && !opponentDeck.isEmpty else {
            checkForGameOver()
            return
        }

        playerCard   = playerDeck.removeFirst() //draw the cards
        opponentCard = opponentDeck.removeFirst()

        if let playerCard = playerCard, let opponentCard = opponentCard {
            if playerCard.rank.rawValue > opponentCard.rank.rawValue { //player wins
                playerDeck.append(playerCard) //player takes the cards
                playerDeck.append(opponentCard)
                if !playerWarCards.isEmpty { //potentially take the cards that were in the war pile
                    playerDeck.append(contentsOf: playerWarCards)
                    playerDeck.append(contentsOf: opponentWarCards)
                    playerWarCards.removeAll() //empty the war piles
                    opponentWarCards.removeAll()
                }
            } else if playerCard.rank.rawValue < opponentCard.rank.rawValue { //opponent wins
                opponentDeck.append(opponentCard)
                opponentDeck.append(playerCard)
                if !opponentWarCards.isEmpty {
                    opponentDeck.append(contentsOf: playerWarCards)
                    opponentDeck.append(contentsOf: opponentWarCards)
                    playerWarCards.removeAll()
                    opponentWarCards.removeAll()
                }
            } else {
                //handle end where player(s) doesn't have enough cards to go to war
                if playerDeck.count < 4 && opponentDeck.count < 4 {
                    playerWarCards.removeAll()
                    opponentWarCards.removeAll()
                    opponentDeck.removeAll()
                    playerDeck.removeAll()
                    winner   = "Tie game!"
                    gameOver = true
                    return
                }
                else if playerDeck.count < 4 { //player doesn't have enough cards to complete the war (and will lose)
                    playerWarCards.removeAll()
                    opponentWarCards.removeAll()
                    playerDeck.removeAll()
                }
                else if opponentDeck.count < 4 {
                    playerWarCards.removeAll()
                    opponentWarCards.removeAll()
                    opponentDeck.removeAll()
                }
                else {
                    performWar()
                }
            }
        }

        checkForGameOver()
    }

    ///handle the tie situation per the game rules
    private func performWar() {
        print("War is happening!")
        isWarHappening.toggle()
        //put cards that caused the war in the temp war decks
        playerWarCards.append(playerCard!)
        opponentWarCards.append(opponentCard!)
        //draw three cards face down
        for _ in 0 ..< 3 {
            if let playerCard = playerDeck.first, let opponentCard = opponentDeck.first {
                playerWarCards.append(playerCard)
                opponentWarCards.append(opponentCard)
                playerDeck.removeFirst()
                opponentDeck.removeFirst()
            }
        }
    }

    ///update game state to reflect whether or not the game is done
    func checkForGameOver() {
        if playerDeck.isEmpty || opponentDeck.isEmpty {
            gameOver = true
            
            if !playerDeck.isEmpty {
                winner = "Player"
            }
            else {
                winner = "Opponent"
            }
        }
    }
}
