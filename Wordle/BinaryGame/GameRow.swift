//
//  GameRow.swift
//  BinaryGame
//
//  Created by Pothapragada, Krishna N on 4/27/26.
//

import Foundation

struct GameRow: Identifiable {
    let id = UUID()
    var bits: [Bit]
    let target: Int
    let isGuess: Bool
}

func makeRow() -> GameRow {
    let isGuess = Bool.random()
    
    let bits = (0..<8).map { i in
        Bit(
            isOn: isGuess ? Bool.random() : false,
            placeVal: 1 << (7 - i)
        )
    }
    
    let target = isGuess ? 0 : Int.random(in: 0...255)
    
    return GameRow(bits: bits, target: target, isGuess: isGuess)
}
