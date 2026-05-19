//
//  BinaryEnter.swift
//  BinaryGame
//
//  Created by Pothapragada, Krishna N on 4/16/26.
//

import SwiftUI

struct BinaryEnter: View {
 
    @Binding var bits: [Bit]
    let target: Int
    
    var game: BinaryGame

    var decimalValue: Int {
        bits.reduce(0) { sum, bit in
            sum + (bit.isOn ? bit.placeVal : 0)
        }
    }

    var body: some View {
        VStack {
            HStack {
                ForEach($bits) { $bit in
                    BinaryEnterButton(bit: $bit)
                        .aspectRatio(1, contentMode: .fit)
                }

                Text("=")

                ZStack {
                    RoundedRectangle(cornerRadius: 12)
                        .frame(width: 60, height: 36)
                        .foregroundStyle(.clear)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(lineWidth: 1)
                        )

                    Text("\(target)")
                        .font(.system(size: 17, weight: .bold, design: .monospaced))
                }
            }
        }
        .padding()
        
       
        .onChange(of: decimalValue) { oldValue, newValue in
            if newValue == target {
                game.rows.removeAll { row in
                    row.bits == bits
                }
                game.checkCleared()
            }
        }
    }
}

#Preview {
    BinaryEnter(bits: .constant([]), target: 0, game: BinaryGame())
}
