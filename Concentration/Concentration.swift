//
//  Concentration.swift
//  Concentration
//
//  Created by Yeh, Louis on 2018/1/16.
//  Copyright © 2018年 Yeh, Louis. All rights reserved.
//

import Foundation

class Concentration
{
    var cards = [Card]()
    var score = 0
    var flipsCounter = 0
    var indexOfOneAndOnlyFaceUpCard: Int?

    func chooseCard(at index: Int) {
        // filter out double clicking card which is already matched
        guard !cards[index].wasMatched else {
            return
        }

        if let matchIndex = indexOfOneAndOnlyFaceUpCard {
            // filter out double clicking case
            guard matchIndex != index else {
                return
            }
            // bingo or mismatch!
            cardMatching(match: matchIndex, choose: index)
            indexOfOneAndOnlyFaceUpCard = nil
        } else {
            // new try
            for flipDownIndex in cards.indices {
                cards[flipDownIndex].isFaceUp = false
            }
            indexOfOneAndOnlyFaceUpCard = index
        }
        flipsCounter += 1
        cards[index].isFaceUp = true
    }
    
    init(numberOfCards: Int) {
        let numberOfPairsOfCards = (numberOfCards + 1) / 2
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            cards += [card,card]
        }
        shuffle()
    }

    private func cardMatching(match matchIndex: Int, choose chooseIndex: Int) {
        if cards[matchIndex].identifier == cards[chooseIndex].identifier {
            cards[matchIndex].wasMatched = true
            cards[chooseIndex].wasMatched = true
            score += 2
        } else {
            let penalty = getPunished(for: chooseIndex) + getPunished(for: matchIndex)
            score += penalty
            cards[matchIndex].wasFliped = true
            cards[chooseIndex].wasFliped = true
        }
    }

    private func shuffle() {
        var oldCards = cards
        var newCards = [Card]()
        while oldCards.count > 0 {
            let randomIndex = Int(arc4random_uniform(UInt32(oldCards.count)))
            newCards.append(oldCards.remove(at: randomIndex))
        }
        cards = newCards
    }

    private func getPunished(for flipedCard: Int) -> Int {
        return cards[flipedCard].wasFliped ? -1 : 0
    }
}
