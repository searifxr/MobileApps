//
//  ContentView.swift
//  BusinessCard
//
//  Created by Pothapragada, Krishna N on 2/3/26.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Button("C", action: {
                print("Played C!")
            })
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.red)
            .foregroundStyle(Color.white)
            Button("D", action: {
                print("Played D!")
            })
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.orange)
            .foregroundStyle(Color.white)
            Button("E", action: {
                print("Played E!")
            })
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.yellow)
            .foregroundStyle(Color.white)
            Button("F", action: {
                print("Played F!")
            })
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.green)
            .foregroundStyle(Color.white)
            Button("G", action: {
                print("Played G!")
            })
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.cyan)
            .foregroundStyle(Color.white)
            Button("A", action: {
                print("Played A!")
            })
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.blue)
            .foregroundStyle(Color.white)
            Button("B", action: {
                print("Played B!")
            })
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.purple)
            .foregroundStyle(Color.white)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
