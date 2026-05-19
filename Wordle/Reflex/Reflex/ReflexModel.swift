import Foundation
import SwiftUI


///the different states of the traffic light simulation
enum TrafficLightState {
    case idle         //before test starts
    case red          //waiting for green
    case green        //tap now
}


///the model for the reflex testing application
class ReflexModel: ObservableObject {
    
    /*
     * the private(set) syntax allows getting but not setting
     */


    ///the state of the app
    @Published private(set) var lightState  : TrafficLightState = .idle
    ///the list of all the reflex attempts the user has made
    @Published private(set) var attempts    : [Attempt]         = []
    ///1-index test number
    @Published private(set) var currentTest : Int               = 1
    ///stores when or not all attempts have been made (5 by default)
    @Published private(set) var isFinished  : Bool              = false


    let maxTests = 5
    let maxWait : TimeInterval = 7.0
    let minWait : TimeInterval = 2.0


    private var greenStartTime : Date?


    ///get the raw average response time
    var average: TimeInterval? {
        guard !attempts.isEmpty else { return nil }
        
        var total: TimeInterval = 0
        
        for attempt in attempts {
            total += attempt.reactionTime
        }
        
        return total / Double(attempts.count)
    }


    ///get the average response time formatted for display
    var averageDisplay: String {
        guard let avg = average else { return "—" }
        
        return String(format: "%.0f ms", avg * 1000)
    }


    ///handle a user event based on the current state of the app
    func handleTap() {
        switch lightState {
            case .idle:
                if !isFinished {
                    startTest()
                }
                
            case .red:
                break //ignore taps while waiting for green
                
            case .green:
                guard let start = greenStartTime else { return }
                
                let elapsed = Date().timeIntervalSince(start)
                
                attempts.append(Attempt(id: currentTest, reactionTime: elapsed))
                            
                advanceOrFinish()
        }
    }
    
    ///ask the model what to show for this (1-index) attempt number
    func getAttemptString(number : Int) -> String {
        guard !attempts.isEmpty        else { return "-" }
        guard number <= attempts.count else { return "-" }
        
        return attempts[number - 1].displayTime
    }


    /// Reset everything back to the beginning.
    func reset() {
        cancelGreenTimer()
        
        attempts    = []
        currentTest = 1
        isFinished  = false
        lightState  = .idle
    }


    private func startTest() {
        lightState = .red
        
        let delay = Double.random(in: minWait ... maxWait)


        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            if self.lightState == .red {
                self.showGreen()
            }
        }
    }


    private func showGreen() {
        greenStartTime = Date()
        lightState     = .green
    }


    private func cancelGreenTimer() {
        lightState = .idle
    }


    private func advanceOrFinish() {
        if currentTest >= maxTests {
            isFinished = true
            lightState = .idle
        }
        else {
            currentTest += 1
            lightState   = .idle
        }
    }
}
