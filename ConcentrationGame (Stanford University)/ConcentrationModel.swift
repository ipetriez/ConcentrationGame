//
//  ConcentrationModule.swift
//  ConcentrationGame (Stanford University)
//
//  Created by Sergey Petrosyan on 7/20/19.
//  Copyright © 2019 Sergey Petrosyan. All rights reserved.
//

import Foundation

struct ConcentrationModel {
    
    private(set) var cards = [Card]()
    private var indexOfOneAndOnlyCard: Int? {
        get {
            return cards.indices.filter { cards[$0].isFaceUp }.oneAndOnly
        }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    
    mutating func chooseCard(at index: Int) {
        assert(cards.indices.contains(index), "Concentration.chooseCard(at: \(index)): chosen index is not in the cards array.")
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyCard, matchIndex != index {
                if cards[matchIndex] == cards[index] {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true
            } else {
                indexOfOneAndOnlyCard = index
            }
        }
    }
    
    
    mutating func startNewGame() {
        for card in cards.indices {
            cards[card].isFaceUp = false
            cards[card].isMatched = false
        }
        shuffle()
    }
    
    
    mutating func shuffle() {
        var randomArray = [Card]()
        while cards.count > 0 {
            let randomizer = cards.count.arc4random
            randomArray.append(cards.remove(at: randomizer))
        }
        cards = randomArray
        randomArray = []
    }
    
    
    
    init(numberOfPairsOfCards: Int) {
        assert(numberOfPairsOfCards > 0, "Concentration.init(\(numberOfPairsOfCards)): you must have at least one pair of cards.")
        for _ in 0..<numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }
        shuffle()
    }
}





extension Collection {
    var oneAndOnly: Element? {
        return count == 1 ? first : nil
    }
}
