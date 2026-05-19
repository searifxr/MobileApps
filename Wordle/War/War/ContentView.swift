//
//  ContentView.swift
//  War
//
//  Created by Pothapragada, Krishna N on 2/23/26.
//

import SwiftUI

struct ContentView: View {
    @StateObject var Game: WarGame = WarGame()
    @State var Oppontent = "back"
    @State var Player = "back"
    @State var hasStarted = false
    @State var opponentCards  = ""
    @State var playerCards = ""
    @State var playerText = "0"
    @State var potemtText = "0"
    @State var showWarAlert = false
    var body: some View {
        VStack {
            Image(Oppontent)
            Spacer()
            Button("Flip Cards!"){
                if !hasStarted {
                    Start()
                    hasStarted.toggle()
                }
                else{
                    update()
                }
            }
            .frame(width: 150, height: 45)
            .background(Color.blue)
            .foregroundStyle(.white)
            .font(.system(size: 20, weight: .semibold))
            .clipShape(RoundedRectangle(cornerRadius: 10))
            Spacer()
            Image(Player)
            Text("Opponent Cards: \(potemtText)")
            Text("Player Cards: \(playerText)")
            
            
        }
        .padding()
        .alert("Prepare for war", isPresented: $showWarAlert){
            Button("Ok", role: .cancel){
                showWarAlert.toggle()
                Game.isWarHappening.toggle()
            }
        } message: {
            Text("Dealing 3 cards faced down")
        }
    }
    
    func Start(){
        Game.startNewGame()
        update()
    }
    func update(){
        Game.drawCards()
        Oppontent = Game.opponentCard?.getImageName() ?? "back"
        Player = Game.playerCard?.getImageName() ?? "back"
        playerText = String(Game.playerDeck.count)
        potemtText = String(Game.opponentDeck.count)
       
        isItTie()
        
        if Game.gameOver{
            hasStarted.toggle()
            if Game.winner == "Player"{
                playerText = "Payer won the game"
                potemtText = "Popem lost"
            }
            else{
                potemtText = "Potent Won"
                playerText = "playser loss 🈯️"
            }
            Player = "back"
            Oppontent = "back"
        }
    }
    
    func isItTie() {
        if Game.isWarHappening {
            showWarAlert.toggle()
        }
    }
    
}

#Preview {
    ContentView()
}

