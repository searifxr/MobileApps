//
//  ContentView.swift
//  RGBMactherSwiftUI
//
//  Created by Pothapragada, Krishna N on 2/11/26.
//

import SwiftUI

struct ContentView: View {
    @State var red = 127.0
    @State var blue = 127.0
    @State var green = 127.0
    
    @State var FindRed = Double.random(in: 0...255)
    @State var FindGreen = Double.random(in: 0...255)
    @State var FindBlue = Double.random(in: 0...255)
    
    @State var showAlert = false
    
    @State var timeRemaining = 30
    @State var gameIsActive = false
        
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    @State var showIfNotWon = false
    
    
    var body: some View {
        
        
        
        
        VStack {
            Text("Time:\(timeRemaining)")
            HStack{
                Rectangle()
                    .foregroundStyle(Color(red: FindRed/255, green:FindGreen/255, blue: FindBlue/255))
                Rectangle().foregroundStyle(Color(red: red/255, green: green/255, blue: blue/255))
            }
            if !gameIsActive {
                Button(action: {
                    gameIsActive = true
                    timeRemaining = 30
                    }) {
                        Text("START GAME")
                        .font(.title)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                            }
                        } else {
                            VStack {
                                Text("Red: \(Int(red))").foregroundStyle(.red)
                                Slider(value: $red, in: 0...255)
                                Text("Green: \(Int(green))").foregroundStyle(.green)
                                Slider(value: $green, in: 0...255)
                                Text("Blue: \(Int(blue))").foregroundStyle(.blue)
                                Slider(value: $blue, in: 0...255)
                            }
                        }
                        
                Spacer(minLength: 100)
            
        }
        .padding()
        .onChange(of: red) {
            ComputeDiff()
        }
        .onChange(of: green){
            ComputeDiff()
        }
        .onChange(of: blue){
            ComputeDiff()
        }
        .alert("You WON!", isPresented: $showAlert) {
            Button("Start over") {
                FindRed = Double.random(in: 0...255)
                FindGreen = Double.random(in: 0...255)
                FindBlue = Double.random(in: 0...255)
                
                red = 127
                green = 127
                blue = 127
                gameIsActive = false
                showAlert = false
            }
        } message: {
            
            Text("You accurately matched them!")
        }
        .alert("You lost!", isPresented: $showIfNotWon) {
            Button("Start over") {
                FindRed = Double.random(in: 0...255)
                FindGreen = Double.random(in: 0...255)
                FindBlue = Double.random(in: 0...255)
                
                red = 127
                green = 127
                blue = 127
                gameIsActive = false
                showIfNotWon = false
            }
        } message: {
            
            Text("Unforutantely you didn't match it in time :(")
        }
        .onReceive(timer) { _ in
            if gameIsActive && timeRemaining > 0 {
                timeRemaining -= 1
                } else if timeRemaining == 0 {
                    gameIsActive = false
                    showIfNotWon = true
                    
                }
            }
        
        
  
         
    }
    func ComputeDiff() {
            let rDiff = red - FindRed
            let gDiff = green - FindGreen
            let bDiff = blue - FindBlue
            
            
            let distance = sqrt((rDiff * rDiff) + (gDiff * gDiff) + (bDiff * bDiff))
            
           
            if distance < 10 {
                showAlert = true
            }
        }
}

#Preview {
    ContentView()
}
