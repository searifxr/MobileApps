//
//  Transactions.swift
//  Mynace
//
//  Created by Pothapragada, Krishna N on 3/3/26.
//

import SwiftUI

struct Transactions: View {
    @State var transcations: [Transaction] = []
    @State var epesive: Double = 100
    var body: some View {
        VStack {
            NavigationStack{
                HStack{
                    Text("Mynance")
                        .font(.title)
                        .bold()
                    Spacer()
                    NavigationLink(destination: moneyizer()){
                        Text("add +++++")
                    }
                }
                .background(Color.brown)
                
            }
            ScrollView{
                VStack{
                    ForEach(transcations) { item in
                        HStack {
                            Text(item.title)
                            Spacer()
                            Text(item.ammount)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                        .foregroundStyle(Color.green)
                        .background(Color.black)
                        .cornerRadius(29)
                        
                    }
                }
                .onAppear {
                    if let data = UserDefaults.standard.data(forKey: "transactions") {
                        transcations = (try? JSONDecoder().decode([Transaction].self, from: data)) ?? []
                    }
                }
                .padding()
                
                
                let totalSpent = transcations.reduce(0) { sum, transaction in
                    sum + (Double(transaction.ammount) ?? 0)
                }

                let epesiveLeft = epesive - totalSpent
                VStack{
                    Text("Epsense: \(epesive)")
                    Text("Spenese spent: \(epesiveLeft)")
                }
                .background(Color.teal)
                
            }
        }
        .padding(20)
        .background(Color.pink)
        .colorInvert()
        
    }
}

#Preview {
    Transactions()
}
