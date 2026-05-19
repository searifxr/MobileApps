//
//  ContentView.swift
//  TypeTester
//
//  Created by Pothapragada, Krishna N on 2/19/26.
//

import SwiftUI

struct ContentView: View {
    
    @State private var timeRemaining = 20
    @State private var timerIsRunning = false
    @State private var randomIndex = 0
    @State private var entry = ""
    @State private var score = 0
    
    @State private var showAlert = false
    @State private var wpm = 0
    
    let totalTime = 20
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack(spacing: 30) {
            
            Text("Time Left: \(timeRemaining)")
                .font(.largeTitle)
            
            Text("Score: \(score)")
                .font(.title2)
            
            Spacer()
            
            if timerIsRunning {
                Text(Words.wordlist[randomIndex])
                    .frame(minWidth: 300)
                    .padding()
                    .border(.blue, width: 2)
                    .font(.system(size: 30))
            } else {
                Text("Press Start")
                    .font(.title)
            }
            
            TextField("Enter Text", text: $entry)
                .frame(minWidth: 300)
                .padding()
                .border(.gray)
                .disabled(!timerIsRunning)
            
            Spacer()
            
            Button(timerIsRunning ? "Game Running" : "Start Timer") {
                startGame()
            }
            .disabled(timerIsRunning)
            
        }
        .padding()
        
        .onReceive(timer) { _ in
            guard timerIsRunning else { return }
            
            if timeRemaining > 0 {
                timeRemaining -= 1
            } else {
                endGame()
            }
        }
        
  
        .onChange(of: entry) {
            guard timerIsRunning else { return }
            
            if entry.lowercased() == Words.wordlist[randomIndex].lowercased() {
                score += 1
                entry = ""
                randomIndex = Int.random(in: 0..<Words.wordlist.count)
            }
        }
        
   
        .alert("Time's Up!", isPresented: $showAlert) {
            Button("OK", role: .cancel) { }
        } message: {
            Text("Score: \(score) \n WPM: \(wpm)")
        }
    }
    
    func startGame() {
        timeRemaining = totalTime
        score = 0
        entry = ""
        randomIndex = Int.random(in: 0..<Words.wordlist.count)
        timerIsRunning = true
    }
    
    func endGame() {
        timerIsRunning = false
        
        let minutes = Double(totalTime) / 60.0
        wpm = Int(Double(score) / minutes)
        
        showAlert = true
    }
}

#Preview {
    ContentView()
}
