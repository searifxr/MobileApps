//
//  BinaryGuessButton.swift
//  BinaryGame
//
//  Created by Pothapragada, Krishna N on 4/29/26.
//

import SwiftUI

struct BinaryGuessButton: View {
    @Binding var bit: Bit
    var body: some View {
    
                ZStack{
                    RoundedRectangle(cornerRadius: 12)
                       
                        .foregroundStyle(.green)
                        
                    Text(bit.isOn ? "1": "0")
                        .font(.system(size: 28, weight: .bold, design: .monospaced))
                
                }
            
            
       
    }
}


#Preview {
    BinaryGuessButton(bit: .constant(Bit(isOn: false, placeVal: 64)))
}
