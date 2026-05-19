//
//  Story.swift
//  Destiny
//
//  Created by Pothapragada, Krishna N on 9/15/25.
//

import Foundation

struct Story{
    let storyText: String
    let choice1: String
    let choice1index: Int
    let choice2: String
    let choice2index: Int
    
    init(storyText: String, choice1: String, choice1index: Int, choice2: String, choice2index: Int) {
        self.storyText = storyText
        self.choice1 = choice1
        self.choice1index = choice1index
        self.choice2 = choice2
        self.choice2index = choice2index
    }
}
