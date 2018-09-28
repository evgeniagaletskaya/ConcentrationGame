//
//  Card.swift
//  Concentration
//
//  Created by Evgenia Galetskaya on 9/26/18.
//  Copyright © 2018 Evgenia Galetskaya. All rights reserved.
//

import Foundation

struct Card {
    var isFaceUp = false
    var isMatched = false
    var identifier: Int
    var numberOfCardFlips = 0
    
    static var identifierFactory = 0
    
    static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }
    
    init(){
        self.identifier = Card.getUniqueIdentifier()
    }
}
