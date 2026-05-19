//
//  WordleTile.swift
//  Wordle
//
//  Created by Pothapragada, Krishna N on 4/10/26.
//

import SwiftUI

struct WordleTile: View {
    var body: some View {
        VStack{
            HStack{
                ForEach(0..<3){ _ in
                    ZStack{
                        Rectangle()
                            .frame(width: 80, height: 80)
                            .border(.black)
                            .foregroundStyle(.white)
                        Text("R")
                    }
                }
            }
        }
        .padding()
    }
}

#Preview {
    WordleTile()
}
