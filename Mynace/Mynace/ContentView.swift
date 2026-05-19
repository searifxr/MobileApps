//
//  ContentView.swift
//  Mynace
//
//  Created by Pothapragada, Krishna N on 3/3/26.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        NavigationStack{
            VStack{
                Text("udghisajf")
                    .font(.title)
                    .bold()
                
                Text("Welcome to mynance tge bets app ever. pls pick one of the options below")
                    .multilineTextAlignment(.center)
                    .padding()
                VStack{
                    NavigationLink(destination: Transactions()){
                        Text("View the world stanard trsansctaion")
                    }
                }
            }
        }
    }
}
#Preview {
    ContentView()
}
