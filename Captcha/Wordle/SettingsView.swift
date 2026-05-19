//
//  SettingsView.swift
//  Wordle
//
//  Created by Pothapragada, Krishna N on 4/1/26.
//

import SwiftUI

struct SettingsView: View {
    @Binding var letThereBeLight: Bool
    
    var body: some View {
        VStack{
            Text("Settings")
                .font(.title)
                .fontWeight(.black)
               
            Divider()
                
            Toggle("Light mode", isOn: $letThereBeLight)
               
            Spacer()
           
        }
        .preferredColorScheme(letThereBeLight ? .light : .dark)
        .padding()
    }
}

#Preview {
    SettingsView(letThereBeLight: .constant(true))
}
