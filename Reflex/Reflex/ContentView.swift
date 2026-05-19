//
//  ContentView.swift
//  Reflex
//
//  Created by Pothapragada, Krishna N on 3/5/26.
//

import SwiftUI

struct ContentView: View {
    
    let resting_opacitiy = 0.5
    let active_opactity = 1.0
    @State var isActive = false
    @StateObject var reflexModel: ReflexModel = ReflexModel()

    
    var body: some View {
        VStack {
            ZStack{
                RoundedRectangle(cornerRadius: 30)
                    .foregroundStyle(LinearGradient(gradient: Gradient(colors: [Color.brown, Color.brown.opacity(0.5)]), startPoint: /*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/, endPoint: /*@START_MENU_TOKEN@*/.trailing/*@END_MENU_TOKEN@*/))
                VStack{
                    Circle()
                        .foregroundStyle(Color.red.opacity( reflexModel.lightState == .red ? active_opactity : resting_opacitiy))
                    Circle()
                        .foregroundStyle(Color.yellow.opacity(reflexModel.lightState == .idle ? active_opactity : resting_opacitiy))
                    Circle()
                        .foregroundStyle(Color.green.opacity( reflexModel.lightState == .green ? active_opactity : resting_opacitiy))
                }
                .padding()
            }
            Button(isActive ? "Click when it turns green" : "Click to begin") {
                reflexModel.handleTap()
                isActive.toggle()
            }
                .padding()
                .background(Color.gray.opacity(0.4))
            Grid(){
                ForEach(0..<5) { row in
                    let attemptNumber = row + 1
                    
                    GridRow(content: {
                        Text("Run: \(attemptNumber)")
                        Text("Attempt timer: \(reflexModel.getAttemptString(number: attemptNumber))")
                    })
                }
            }
            Button("Reset"){
                reflexModel.reset()
            }
            .disabled(isActive)
        }
        .padding()

        
    }
    
}

#Preview {
    ContentView()
}
