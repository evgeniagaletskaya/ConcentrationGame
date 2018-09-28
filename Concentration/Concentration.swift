//
//  Concentration.swift
//  Concentration
//
//  Created by Evgenia Galetskaya on 9/26/18.
//  Copyright © 2018 Evgenia Galetskaya. All rights reserved.
//

import Foundation

class Concentration {
    
    var cards = [Card]()
    var score = 0
    var flips = 0
    
    // check if only ONE card is face up
    var indexOfOneAndOnlyFaceUpCard: Int?
    
    func chooseCard(at index: Int) {
        flips += 0
        //if card at this index is already matched, ignore it
        if !cards[index].isMatched {
            
            //if there IS one and only one card face up, take its index & make sure its index isn't the same, that you chose
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                // check if cards match
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    score += 2
                    print("2 cards matched")
                } else  if cards[index].numberOfCardFlips > 0 || cards[matchIndex].numberOfCardFlips > 0 {
                    score -= 1
                    print("one of the cards was already seen")
                }
                cards[index].isFaceUp = true // if the 2 cards didn't match, the chosen card is now face up
                indexOfOneAndOnlyFaceUpCard = nil // and there's no more one and only one card face up
                cards[index].numberOfCardFlips += 1
                cards[matchIndex].numberOfCardFlips += 1
            } else {
                // either no cards or 2 cards are face up
                for flipDownIndex in cards.indices {
                    cards[flipDownIndex].isFaceUp = false
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = index
                }
            }
        }
    
    func resetCards(){
        cards.removeAll()
    }
    
    init (numberOfPairsOfCards: Int) {
        //TODO: shuffle the cards - COMPLETE
        var preShuffledCards = [Card]()
        
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            preShuffledCards += [card,card]
        }
        for _ in preShuffledCards{
            let randomCardIndex = Int(arc4random_uniform(UInt32(preShuffledCards.count)))
            let randomCard = preShuffledCards.remove(at: randomCardIndex)
            cards.append(randomCard)
        }
     }
}
