//
//  ContentView.swift
//  Dice
//
//  Created by Pothapragada, Krishna N on 1/30/26.
//

import SwiftUI

struct ContentView: View {
    let dice = Int.random(in: 1...6)
    
    var body: some View {
        VStack(spacing: 20) {
            Image("dice-\(dice)")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("You rolled a \(dice)")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
