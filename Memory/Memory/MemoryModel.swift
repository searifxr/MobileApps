//
//  MemoryModel.swift
//  Memory
//
//  Created by Pothapragada, Krishna N on 3/11/26.
//

import Foundation

class MemoryModel: ObservableObject {
    @Published var MemoryCards: [MemoryCard] = []
    var firstCardIndex: Int? = nil
    @Published var gameFinished = false

    private let emojis: [String] = [
        "😀", "😃", "😄", "😁", "😆", "😅", "😂", "🤣", "😊", "😇",
        "🙂", "🙃", "😉", "bonjour", "😌", "😍", "🥰", "😘", "😗", "😙", "😚",
        "😋", "😛", "😝", "😜", "🤪", "🤨", "🧐", "🤓", "😎", "🥸",
        "🤩", "🥳", "😏", "😒", "😞", "😔", "😟", "😕", "🙁", "☹️",
        "😣", "😖", "😫", "😩", "🥺", "😢", "😭", "😤", "😠", "😡",
        "🤬", "🤯", "😳", "🥵", "🥶", "😱", "😨", "😰", "😥", "😓",
        "🤗", "🤔", "🫣", "🤭", "🫢", "🫡", "🤫", "🫠", "🤥", "😶",
        "🫥", "😐", "🫤", "😑", "😬", "🙄", "😯", "😦", "😧", "😮",
        "😲", "🥱", "😴", "🤤", "😪", "😵", "🤐", "🥴", "🤢", "🤮",
        "🤧", "😷", "🤒", "🤕", "🤑", "🤠", "😈", "👿", "👹", "👺",
        "💀", "☠️", "👻", "👽", "🤖", "🎃", "😺", "😸", "😹", "😻",
        "😼", "😽", "🙀", "😿", "😾",
        "👋", "🤚", "🖐️", "✋", "🖖", "👌", "🤌", "🤏", "✌️", "🤞",
        "🫶", "🤟", "🤘", "🤙", "👈", "👉", "👆", "👇", "☝️", "👍",
        "👎", "✊", "👊", "🤛", "🤜", "👏", "🙌", "👐", "🤲", "🤝",
        "🙏", "💪", "🦾", "🦵", "🦶",
        "🐶", "🐱", "🐭", "🐹", "🐰", "🦊", "🐻", "🐼", "🐻‍❄️", "🐨",
        "🐯", "🦁", "🐮", "🐷", "🐸", "🐵", "🙈", "🙉", "🙊", "🐔",
        "🐧", "🐦", "🐤", "🐣", "🐥", "🦆", "🦅", "🦉", "🦇", "🐺",
        "🐗", "🐴", "🦄", "🐝", "🐛", "🦋", "🐌", "🐞", "🐢", "🐍",
        "🦎", "🐙", "🦑", "🦀", "🐡", "🐠", "🐟", "🐬", "🐳", "🐋",
        "🦈", "🐊",
        "🍏", "🍎", "🍐", "🍊", "🍋", "🍌", "🍉", "🍇", "🍓", "🫐",
        "🍈", "🍒", "🍑", "🥭", "🍍", "🥥", "🥝", "🍅", "🍆", "🥑",
        "🥦", "🥕", "🌽", "🥔", "🍠", "🥐", "🍞", "🥖", "🧀", "🥚",
        "🍳", "🥞", "🧇", "🥓", "🍗", "🍖", "🌭", "🍔", "🍟", "🍕",
        "🥪", "🌮", "🌯", "🥗", "🍝", "🍜", "🍣", "🍤", "🍙", "🍚",
        "🍘", "🍥", "🥠", "🥟", "🍦", "🍧", "🍨", "🍩", "🍪", "🎂",
        "🍰", "🧁", "🍫", "🍬", "🍭",
        "⚽️", "🏀", "🏈", "⚾️", "🎾", "🏐", "🏉", "🎱", "🏓", "🏸",
        "🥅", "🏒", "🏑", "🥍", "🏏", "⛳️", "🏹", "🎣", "🥊", "🥋",
        "🎮", "🕹️", "🎲", "♟️",
        "🚗", "🚕", "🚙", "🚌", "🚎", "🏎️", "🚓", "🚑", "🚒", "🚐",
        "🚚", "🚛", "🚜", "🏍️", "🛵", "🚲", "🛴", "🚨", "🚔", "🚍",
        "✈️", "🛫", "🛬", "🚀", "🛸",
        "🌍", "🌎", "🌏", "🌙", "⭐️", "🌟", "✨", "⚡️", "🔥", "💧",
        "🌈", "☀️", "⛅️", "☁️", "🌧️", "⛈️", "❄️", "☃️",
        "❤️", "🧡", "💛", "💚", "💙", "💜", "🖤", "🤍", "🤎", "💔",
        "💯", "✔️", "❌", "⚠️", "⭐️", "🏆", "🥇", "🥈", "🥉",
    ]

    init() {
        startGame()
    }

    func startGame() {
        var newCards: [MemoryCard] = []
        let shuffledEmojis = emojis.shuffled().prefix(6)

        for emoji in shuffledEmojis {
            newCards.append(Memory.MemoryCard(content: emoji))
            newCards.append(Memory.MemoryCard(content: emoji))
        }

        MemoryCards = newCards
        MemoryCards.shuffle()
    }

    func handleTouch(cardID: UUID) {
        for index in MemoryCards.indices {
            if MemoryCards[index].id == cardID {
                
                if MemoryCards[index].isMatched { return }
                
                if let first = firstCardIndex {
                    
                    MemoryCards[index].isFacingUp = true
                    checkMatch(index1: first, index2: index)
                    firstCardIndex = nil
                    
                } else {
                    
                    for i in MemoryCards.indices {
                        if !MemoryCards[i].isMatched {
                            MemoryCards[i].isFacingUp = false
                        }
                    }
                    
                    MemoryCards[index].isFacingUp = true
                    firstCardIndex = index
                }
            }
        }
    }

    func checkMatch(index1: Int, index2: Int) {
        if MemoryCards[index1].content == MemoryCards[index2].content {
            MemoryCards[index1].isMatched = true
            MemoryCards[index2].isMatched = true
        }
        
        checkGameFinished()
    }

    func checkGameFinished() {
        if MemoryCards.allSatisfy({ $0.isMatched }) {
            gameFinished = true
        }
    }
}
