//
//  BinaryGuess.swift
//  BinaryGame
//
//  Created by Pothapragada, Krishna N on 4/29/26.
//

import SwiftUI

struct BinaryGuess: View {
    
    let bits: [Bit]
    var game: BinaryGame
    
    @State private var guess: String = ""
    
    var correctValue: Int {
        bits.reduce(0) { sum, bit in
            sum + (bit.isOn ? bit.placeVal : 0)
        }
    }
    
    var body: some View {
        HStack {
  
            ForEach(bits) { bit in
                BinaryGuessButton(bit: .constant(bit))
                    .aspectRatio(1, contentMode: .fit)
            }
            
            Text("=")
        
            TextField("?", text: $guess)
                .frame(width: 60, height: 36)
                .textFieldStyle(.roundedBorder)
                .keyboardType(.numberPad)
                .multilineTextAlignment(.center)
                .font(.system(size: 17, weight: .bold, design: .monospaced))
        }
        .padding()
        
 
        .onChange(of: guess) {
            if let value = Int(guess), value == correctValue {
                removeSelf()
                game.checkCleared()
            }
        }
    }
    
    func removeSelf() {
        game.rows.removeAll { row in
            row.bits == bits
        }
   
    }
}

#Preview {
    BinaryGuess(bits: [], game: BinaryGame())
}
