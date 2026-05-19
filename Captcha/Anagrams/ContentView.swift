//
//  ContentView.swift
//  Anagrams
//
//  Created by Pothapragada, Krishna N on 2/25/26.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var model = ListModel()
    @State var enteredText = ""
    @State var TheWord = ""
    @State var Score = 0
    private let checker = UITextChecker()
    @State var randomIndex = 0
    @State var hasStarted = false
   var found: [String] {
        model.found
    }
    var body: some View {
        VStack {
            HStack{
                Text(hasStarted ? TheWord : "Word will appear")
                    .font(.title)
                    .bold()
                Spacer()
                Text("Score")
            }
            .padding()
            TextField("Enter your word", text: $enteredText)
                .padding()
                .frame(maxHeight: 70)
                .overlay(content: {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.gray, lineWidth: 1)
                })
                .padding()
                .autocorrectionDisabled(true)
                .onSubmit {
                    guard !enteredText.isEmpty else {return}
                    
                    if isReal(word: enteredText){
                        model.found.append(enteredText)
                        enteredText=""
                    }
                }
            Spacer()
            ZStack{
                Rectangle()
                    .fill(Color.gray.opacity(0.2))
                    .frame(width: 420, height: 600)
                    VStack{
                        ForEach(found, id:\.self){word in
                            HStack{
                                Text(word)
                                Spacer()
                                ForEach(Array(word), id: \.self){ _ in
                                    Text("*")
                                    $Score += 1
                                }
                            }
                            .padding(5)
                            .background( Color.white)
                            .cornerRadius(6)
                        }
                        
                    }
                    .padding()
            }
            Button(hasStarted ? "New Word" : "Start game"){
                let randomIndex = Int.random(in: 0..<model.TextList.count)
                TheWord = String(model.TextList[randomIndex])
                hasStarted = true
            }
        }
        .padding()
    
    }
    func isReal(word: String) -> Bool {
        
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        
        return misspelledRange.location == NSNotFound
    }

}

#Preview {
    ContentView()
}
