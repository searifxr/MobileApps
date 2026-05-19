//
//  ContentView.swift
//  Memory
//
//  Created by Pothapragada, Krishna N on 3/11/26.
//

import SwiftUI

struct ContentView: View {
    @StateObject var model: MemoryModel = MemoryModel()
    
    var body: some View {
        if !model.gameFinished { VStack {
            ScrollView{
                Grid(alignment: .center, horizontalSpacing: 10, verticalSpacing: 10) {
                    ForEach(model.MemoryCards) { card in
                        GridRow {
                            CardView(card: card)
                                .onTapGesture {
                                    model.handleTouch(cardID: card.id)
                                }
                        }
                    }
                }
            }
        }
        .padding()
    }
        else{
            VStack{
                Text("Congrats")
                Image("lebronJamesHairline")
                Button("try out lebron hariline", action: {
                    model.startGame()
                    model.gameFinished.toggle()
                })
            }
        }
    }
    
}

#Preview {
    ContentView()
}
