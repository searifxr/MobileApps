//
//  Card.swift
//  War_SwiftUI
//
//  Created by BUNN, BRYAN on 8/6/24.
//

import Foundation

//Suit is an enum but also a String, for loading the images
enum Suit: String, CaseIterable {
    case hearts   = "hearts"
    case diamonds = "diamonds"
    case clubs    = "clubs"
    case spades   = "spades"
}

//Rank is an enum but also an int (for easy comparison)
enum Rank: Int, CaseIterable {
    case two = 2, three = 3, four = 4, five = 5, six = 6, seven = 7, eight = 8, nine = 9, ten = 10
    case jack = 11, queen = 12, king = 13, ace = 14
}

struct Card: Identifiable {
    let id = UUID() //needed for for-each, not using at the moment
    let suit : Suit
    let rank : Rank
    
    ///get the file name of the card image based on the rank and suit
    func getImageName() -> String {
        var img = rank.rawValue <= 10 ? String(rank.rawValue) : "\(rank)"
        img += "_of_" + "\(suit)"
        
        return img
    }
}
