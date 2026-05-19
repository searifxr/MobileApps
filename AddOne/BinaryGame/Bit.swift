//
//  Bit.swift
//  BinaryGame
//
//  Created by Pothapragada, Krishna N on 4/16/26.
//

import Foundation

struct Bit: Identifiable, Equatable {
    let id = UUID()
    var isOn: Bool
    let placeVal: Int
    
    mutating func tog(){
        isOn.toggle()
    }
}
