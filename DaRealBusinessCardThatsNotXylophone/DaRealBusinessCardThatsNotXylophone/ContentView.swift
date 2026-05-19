//
//  ContentView.swift
//  DaRealBusinessCardThatsNotXylophone
//
//  Created by Pothapragada, Krishna N on 2/3/26.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        ZStack{
            Color.cyan
            VStack{
                Spacer(minLength: 180)
                Image("Profile Picture")
                    .clipShape(Circle())
                    .overlay(content: {
                        RoundedRectangle(cornerRadius: 100)
                            .stroke( Color.white, lineWidth: 5)
                    })
                Text("Krishna Pothapragada")
                    .font(.title)
                    .bold()
                Text("Aspiring ML engineer")
                    .font(.subheadline)
                Spacer(minLength: 40)
                ZStack{
                    RoundedRectangle(cornerRadius: 50)
                    
                    Text("972-859-0903")
                        .foregroundStyle(Color.blue)
                }
                ZStack{
                    RoundedRectangle(cornerRadius: 50)
                    
                    Text("krishna.pothapragada.607@k12.friscoisd.org")
                        .foregroundStyle(Color.blue)
                }
                
                
                
                Spacer(minLength: 200)
            }
            .foregroundStyle(Color.white)
            
            
        }
        .padding()
        .background(Color.cyan)
    }
}

#Preview {
    ContentView()
}
