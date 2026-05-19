//
//  HELPMEjoleinmYshoes.swift
//  Wordle
//
//  Created by Pothapragada, Krishna N on 4/10/26.
//

import SwiftUI

struct HELPMEjoleinmYshoes: View {
    @Binding var letThereBeLight: Bool
    var body: some View {
        VStack{
            HStack{
                Text("How to play")
                    .bold()
                    .font(.title)
                Spacer()
            }
            Divider()
            Image(letThereBeLight ? "help_light" : "help_dark")
                .resizable()
                .frame(width: 400,height: 80)
            Spacer()
           
        }
        .preferredColorScheme(letThereBeLight ? .light : .dark)
        .padding()
    }
}

#Preview {
    HELPMEjoleinmYshoes(letThereBeLight:.constant(true))
}
