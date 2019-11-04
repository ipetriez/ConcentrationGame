//
//  Card.swift
//  ConcentrationGame
//
//  Created by Sergey Petrosyan on 10/21/19.
//  Copyright © 2019 Sergey Petrosyan. All rights reserved.
//

import Foundation

struct Card: Hashable {
    var isFaceUp = false
    var isMatched = false
    private var identifier: Int
    private static var identifierFactory = 0
    
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
    
    
    static func == (lhs: Card, rhs: Card) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    
    
    private static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }
    
    
    init() {
        identifier = Card.getUniqueIdentifier()
    }
}
