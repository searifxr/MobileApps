//
//  BinaryEnterButton.swift
//  BinaryGame
//
//  Created by Pothapragada, Krishna N on 4/16/26.
//

import SwiftUI

struct BinaryEnterButton: View {
    @Binding var bit: Bit
    var body: some View {
    
            Button {
                withAnimation{
                    bit.isOn.toggle()
                }
            } label: {
                ZStack{
                    RoundedRectangle(cornerRadius: 12)
                       
                        .foregroundStyle(bit.isOn ?  .orange : .blue)
                        
                    Text(bit.isOn ? "1": "0")
                        .font(.system(size: 28, weight: .bold, design: .monospaced))
                        .foregroundStyle(bit.isOn ? .blue : .orange)
                }
            }
            
       
    }
}

#Preview {
    BinaryEnterButton( bit: .constant(Bit(isOn: false, placeVal: 64)))
}
