//
//  BinaryGame.swift
//  BinaryGame
//
//  Created by Pothapragada, Krishna N on 4/27/26.
//

import Foundation


class BinaryGame: ObservableObject {
    @Published var rows: [GameRow] = []
    @Published var lost: Bool = false
    @Published var cleared: Bool = false
    private var timer: Timer?
    
    @Published var bits: [Bit] = (0..<8).map { i in
            Bit(isOn: false, placeVal: 1 << (7 - i))
    }
    
    let maxRows: Int = 8
    
    var TimerInternval: Double = 15.0
    
    init() {
        rows.append(makeRow())
        startTimer()
    }
    
    func addRow() {
        if rows.count >= maxRows {
            lost = true
            timer?.invalidate()
            return
        }
        
        rows.append(makeRow())
    }
    
    func removeFirstRowIfNeeded() {
        if rows.count > maxRows {
            rows.removeFirst()
        }
    }
    
    func gameReset() {
        timer?.invalidate()
        
        rows = []
        lost = false
        cleared = false
        
        rows.append(makeRow())
        startTimer()
    }

    
    func checkLoss() {
        if rows.count > maxRows {
            lost = true
        }
    }
    
    func checkCleared(){
        if rows.count == 0{
            cleared = true
        }
        
        if cleared {
            increaseLevel()
        }
    }
    
    func startTimer() {
        timer?.invalidate()
        
        timer = Timer.scheduledTimer(withTimeInterval: Double(TimerInternval), repeats: true) { [weak self] _ in
            self?.timerTick()
        }
    }
    
    private func timerTick() {
        guard !lost else {
            timer?.invalidate()
            return
        }
        
        addRow()
    }
    
    func checkRow(_ row: GameRow) {
            let value = row.bits.reduce(0) {
                $0 + ($1.isOn ? $1.placeVal : 0)
            }
            
            if value == row.target {
                removeRow(row)
            }
    }
    
    func removeRow(_ row: GameRow) {
            rows.removeAll { $0.id == row.id }
    }
    
    func checkRow(_ row: GameRow, guess: Int? = nil) {
        let value = row.bits.reduce(0) {
            $0 + ($1.isOn ? $1.placeVal : 0)
        }
        
        if row.isGuess {
            if guess == value {
                removeRow(row)
            }
        } else {
            if value == row.target {
                removeRow(row)
            }
        }
    }
    
    func increaseLevel() {
        TimerInternval -= 2
        if TimerInternval < 5 {
            TimerInternval = 5
        }
        startTimer()
    }
}
