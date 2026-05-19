import Foundation

///a single reaction attempt
///id is 1-index to mirror the results table
struct Attempt: Identifiable {
    let id           : Int
    let reactionTime : TimeInterval

    ///format the reaction time for display purposes
    var displayTime: String {
        String(format: "%.0f ms", reactionTime * 1000)
    }
}
