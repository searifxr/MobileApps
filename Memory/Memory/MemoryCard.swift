//
//  Card.swift
//  Memory
//
//  Created by Pothapragada, Krishna N on 3/11/26.
//
import Foundation
import SwiftUI

struct MemoryCard: Identifiable {
    var id = UUID()
    let content: String
    var isFacingUp: Bool = false
    var isMatched: Bool = false
}

struct CardView: View {
    
    let card: MemoryCard
    
    var body: some View {
        let baseShape = RoundedRectangle(cornerRadius: 20)
        
        ZStack{
            if card.isFacingUp {
                baseShape.fill(.white)
                baseShape.stroke(lineWidth: 3)
                Text(card.content)
                    .font(.callout)
            }
            else{
                baseShape.fill(.blue)
            }
        }
        .frame(width: 80, height: 120)
        .opacity(card.isMatched ? 0 : 1)
    }
}
