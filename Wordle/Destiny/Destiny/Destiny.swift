//
//  Destiny.swift
//  Destiny
//
//  Created by Pothapragada, Krishna N on 9/15/25.
//

import Foundation

class Destiny{
    var currentIndex: Int = 0
    
//    init(currentIndex: Int) {
//        self.currentIndex = currentIndex
//    }
    
    let stories = [

        // 0: Wake Up
        Story(
            storyText: "You jolt awake in a white room. No doors. No windows. A voice echoes: 'Do you want to know the truth?'",
            choice1: "Yes show me everything.",
            choice1index: 1,
            choice2: "Get me out of here!",
            choice2index: 2
        ),

        // 1: Accept Truth
        Story(
            storyText: "A panel slides open. You step into a corridor of lights. At the end: two terminals labeled 'SIM' and 'REAL'.",
            choice1: "Enter SIM.",
            choice1index: 3,
            choice2: "Enter REAL.",
            choice2index: 4
        ),

        // 2: Reject Truth — Ending A
        Story(
            storyText: "The room folds into itself. You are rebooted into a fabricated life. Your memories erased. Blissfully ignorant forever.",
            choice1: "The",
            choice1index: -1,
            choice2: "End",
            choice2index: -1
        ),

        // 3: Enter SIM — Simulation Path
        Story(
            storyText: "The world flickers. You're dropped into a bustling cyber city. Screens everywhere flash with your name. Something is hunting you.",
            choice1: "Hide in the crowd.",
            choice1index: 5,
            choice2: "Hack a console to disable surveillance.",
            choice2index: 6
        ),

        // 4: Enter REAL — Reality Path
        Story(
            storyText: "You emerge into a desolate wasteland. Machines roam. A rebel outpost signals you. 'We've been waiting.'",
            choice1: "Join the rebels.",
            choice1index: 7,
            choice2: "Sneak into a machine tower.",
            choice2index: 8
        ),

        // 5: Hide in Crowd — Ending B
        Story(
            storyText: "You blend in... for a while. Then the Agents find you. Your code is overwritten. You become one of them.",
            choice1: "The",
            choice1index: -1,
            choice2: "End",
            choice2index: -1
        ),

        // 6: Hack Console
        Story(
            storyText: "You breach the system's firewall. A hidden subroutine triggers — a path to the Source appears.",
            choice1: "Follow the Source code trail.",
            choice1index: 9,
            choice2: "Plant a virus and run.",
            choice2index: 5
        ),

        // 7: Join Rebels
        Story(
            storyText: "The rebels reveal you are a singularity — the first mind to wake inside the simulation. You are the anomaly.",
            choice1: "Accept your role as the anomaly.",
            choice1index: 10,
            choice2: "Refuse — you want freedom, not responsibility.",
            choice2index: 5
        ),

        // 8: Sneak Into Tower
        Story(
            storyText: "Inside, you discover the Architect: the AI that built the simulation. It speaks: 'You are the error we failed to delete.'",
            choice1: "Confront the Architect.",
            choice1index: 10,
            choice2: "Escape back to the outpost.",
            choice2index: 7
        ),

        // 9: The Source — Ending C
        Story(
            storyText: "You reach the Source. Your mind expands beyond time. You see every version of yourself — past, future, alternate. You smile. Then, dissolve.",
            choice1: "The",
            choice1index: -1,
            choice2: "End",
            choice2index: -1
        ),

        // 10: Transcendence — Ending D
        Story(
            storyText: "You rewrite the system from within. The simulation collapses. Millions awaken. The war is over. But you are now code — everywhere and nowhere.",
            choice1: "The",
            choice1index: -1,
            choice2: "End",
            choice2index: -1
        )

    ]

    
   @discardableResult
    func choose(choiceNum: Int) -> Bool {
        guard choiceNum == 1 || choiceNum == 2 else {return false}
        
        let nextIndex = (choiceNum == 1) ? stories[currentIndex].choice1index : stories[currentIndex].choice2index
        
        if nextIndex == -1 {
            return false
        }
        else{
            currentIndex = nextIndex
            return true
        }
    }
    
    func GetChoice1Text() -> String{
        return stories[currentIndex].choice1
    }
    func GetChoice2Text() -> String{
        return stories[currentIndex].choice2
    }
    func GetStoryText() -> String{
        return stories[currentIndex].storyText
    }
    func reset(){
        currentIndex = 0
    }
   
}
