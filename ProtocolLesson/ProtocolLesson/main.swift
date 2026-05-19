//
//  main.swift
//  ProtocolLesson
//
//  Created by Pothapragada, Krishna N on 2/5/26.
//

import Foundation

struct TimeOfDay: Strideable {
    var hours: Int
    var minutes: Int

    func distance(to other: TimeOfDay) -> Int {
        (other.hours * 60 + other.minutes) - (hours * 60 + minutes)
    }

    func advanced(by n: Int) -> TimeOfDay {
        let total = hours * 60 + minutes + n
        let newHours = (total / 60) % 24
        let newMinutes = total % 60
        return TimeOfDay(hours: newHours, minutes: newMinutes)
    }
    
    
}
let start = TimeOfDay(hours: 9, minutes: 0)
let end = TimeOfDay(hours: 11, minutes: 30)

for time in stride(from: start, through: end, by: 15) {
    print("\(time.hours):\(time.minutes)") //don't worry about formatting


}

