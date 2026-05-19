//
//  BinaryEnterButton.swift
//  BinaryGame
//
//  Created by Pothapragada, Krishna N on 4/16/26.
//

import SwiftUI

struct Numbers: View {
    var numb: Int
    var body: some View {
    
            
                ZStack{
                    RoundedRectangle(cornerRadius: 5)
                       
                        .foregroundStyle(.blue)
                        
                    Text("\(numb)")
                        .font(.system(size: 18, weight: .bold, design: .monospaced))
                        .foregroundStyle(.orange)
                }
                .frame(width: 40, height: 40)
            
            
       
    }
}

#Preview {
    Numbers(numb: 1)
}
