//
//  ContentView.swift
//  BinaryGame
//
//  Created by Pothapragada, Krishna N on 4/16/26.
//

import SwiftUI


struct ContentView: View {
    @StateObject private var game = BinaryGame()
 
    
    
    
    var body: some View {
        VStack() {
            
            Spacer()
            ForEach($game.rows) { $row in
                if row.isGuess {
                    BinaryGuess(bits: row.bits, game: game)
                } else {
                    BinaryEnter(bits: $row.bits, target: row.target, game: game)
                }
            }
            
            if let firstRow = game.rows.first {
                HStack(spacing: 10) {
                    Spacer()
                    ForEach(firstRow.bits) { bit in
                        Numbers(numb: bit.placeVal)
                    }
                    Spacer()
                }
                
            }
         
            
        }
        .frame(maxHeight: .infinity, alignment: .bottom)
        .padding()
        .alert("You Lost", isPresented: $game.lost) {
            Button("Ok", role: .cancel) {
                game.gameReset()
            }
        }
    }
    
}

#Preview {
    ContentView()
}
        
