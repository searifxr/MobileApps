//
//  ContentView.swift
//  PasswordGenerator
//
//  Created by Pothapragada, Krishna N on 2/17/26.
//

import SwiftUI

struct ContentView: View {
    
    private let uppercaseLetters
    = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    private let lowercaseLetters = "abcdefghijklmnopqrstuvwxyz"
    private let numbers = "0123456789"
    private let symbols = "!@#$%^&*()_+-=[]{}|;:,.<>?"
    
    @State var letUppercaseLetters = false
    @State var letLowercaseLetters = false
    @State var letNumbers = false
    @State var letSymbolCase = false
    @State var pwdLength: Double = 0
    
    @State var pwd = ""
    var body: some View {
        VStack {
            Spacer()
            Toggle(isOn: $letLowercaseLetters){
                Text("Include uppercase letters")
                }
            Toggle(isOn: $letUppercaseLetters){
                Text("Include LOWERCASE letters")
                }
            Toggle(isOn:  $letSymbolCase){
                Text("Include numbercase letters?(<>?!-+)")
                }
            Toggle(isOn: $letNumbers ){
                Text("Include symbolCase letters(123456789)")
                }
            Spacer()
            Text("Pwd size: \(Int(pwdLength))")
            Slider(value: $pwdLength, in:0...1000, step:157)
            
            Spacer()
            Button("Generate Password") {
                let length = Int(pwdLength)
                
                var pools: [String] = []
                if letUppercaseLetters { pools.append(uppercaseLetters) }
                if letLowercaseLetters { pools.append(lowercaseLetters) }
                if letNumbers { pools.append(numbers) }
                if letSymbolCase { pools.append(symbols) }
                guard !pools.isEmpty, length > 0 else {
                    pwd = "Select an option"
                    return
                }
                var result: [Character] = []
                for pool in pools {
                    if let c = pool.randomElement() {
                        result.append(c)
                    }
                }
                let allChars = Array(pools.joined())
                let remaining = length - result.count
                
                if remaining > 0 {
                    for _ in 0..<remaining {
                        if let c = allChars.randomElement() {
                            result.append(c)
                        }
                    }
                }

                result.shuffle()
                pwd = String(result)
            }
            Text("Your passwurd: \(pwd)")
                .font(.system(size: 29))
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
