//
//  ContentView.swift
//  Wordle
//
//  Created by Pothapragada, Krishna N on 4/1/26.
//

import SwiftUI

struct ContentView: View {
    @State var letThereBeLight = true
    @StateObject var WordleModel: WordleBackend = WordleBackend()
    @State private var hasLoaded = false
    
    var body: some View {
        NavigationStack{
            VStack {
                HStack{
                    NavigationLink(destination: HELPMEjoleinmYshoes(letThereBeLight: $letThereBeLight), label: {
                        Image(systemName: "person.fill.questionmark")
                    })
                    .foregroundStyle(letThereBeLight ? .black : .white)
                    Spacer()
                    Spacer()
                    NavigationLink( destination: SettingsView(letThereBeLight: $letThereBeLight)){
                        Image(systemName: "gear.circle")
                    }                    .foregroundStyle(letThereBeLight ? .black : .white)
                }
                Text("WORDLE")
                    .font(.title)
                    .fontWeight(.black)
                    .frame(alignment: .center)
                
                Spacer()
                TextField("Enter Word", text: $WordleModel.currentInput)
                    .onChange(of: WordleModel.currentInput) {
                        if WordleModel.currentInput.count > 5 {
                            WordleModel.currentInput = String(WordleModel.currentInput.prefix(5))
                        }
                        
                        if WordleModel.currentInput.count == 5 {
                            WordleModel.submitGuess()
                            print("Submitting guess")
                        
                        }
                    }
                    .multilineTextAlignment(.center)
                Spacer()
                ForEach(0..<6){row in
                    HStack(spacing: 5){
                        ForEach(0..<5){ col in
                            ZStack{
                                Rectangle()
                                    .frame(maxWidth: 80, maxHeight: 80)
                                    .foregroundStyle(letThereBeLight ? .white : .black)
                                    .border(letThereBeLight ? Color.black : Color.white)
                                
                                if row < WordleModel.guesses.count && col < WordleModel.guesses[row].count {
                                    let tile = WordleModel.guesses[row][col]

                                    Text(tile.letter.uppercased())
                                        .font(.title)
                                        .foregroundColor(.white)
                                        .frame(maxWidth: 80, maxHeight: 80)
                                        .background(tileColor(tile.color))
                                                        .font(.title)
                                                        .foregroundStyle(letThereBeLight ? .black : .white)
                                                }
                            }
                        }
                    }
                }
                Spacer()
                
            }
            .padding()
            .preferredColorScheme(letThereBeLight ? .light : .dark)
            .onAppear {
                if !hasLoaded{
                    WordleModel.loadWords()
                    WordleModel.pickWord()
                    print(WordleModel.validWords.count)
                    hasLoaded = true
                }
            }
            .disabled(WordleModel.gameOver)
            .sheet(isPresented: $WordleModel.DidWin) {
                WinView(onRestart: {
                    WordleModel.reset()
                })
            }
            .alert("u lost trash gng 🇨🇳🈯️☠︎℞🀕🁎⌱⎧㉿", isPresented: Binding(
                get: { WordleModel.gameOver && !WordleModel.DidWin },
                set: { _ in }
            )) {
                Button("OK", role: .cancel) {
                    WordleModel.reset()
                }
            }
            
        }
        
    }
    func tileColor(_ color: TileColor) -> Color {
        switch color {
        case .green: return .green
        case .yellow: return .yellow
        case .gray: return .gray
        }
    }
}

#Preview {
    ContentView()
}
