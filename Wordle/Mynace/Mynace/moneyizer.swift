//
//  moneyizer.swift
//  Mynace
//
//  Created by Pothapragada, Krishna N on 3/3/26.
//

import SwiftUI

struct moneyizer: View {
    
    @State var transcations: String = ""
    @State var ammount: String = "0.0"
    var body: some View {
        VStack{
            Text("Enter trnsacrtion")
                .bold()
                .fontWeight(Font.Weight.black)
                .font(.system(size: 130))
            Spacer()
            HStack{
                TextField("Enter title", text: $transcations)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                TextField("Enter ammount", text: $ammount)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                Button(){
                    let transaction = Transaction(title: transcations, ammount: ammount)
                    
                    var transactions = loadTransactions()
                    transactions.append(transaction)

                    if let encoded = try? JSONEncoder().encode(transactions) {
                        UserDefaults.standard.set(encoded, forKey: "transactions")
                    }
                    
                } label: {
                    Text("+")
                }
            }
            Spacer()
        }
        .padding()
        .background(Color.indigo)

      
    }
    func loadTransactions() -> [Transaction] {
        if let data = UserDefaults.standard.data(forKey: "transactions") {
            return (try? JSONDecoder().decode([Transaction].self, from: data)) ?? []
        }
        return []
    }

}

#Preview {
    moneyizer()
}

struct Transaction: Codable, Identifiable {
    var id = UUID()
    
    var title: String
    var ammount: String
    
   
}
