//
//  Card.swift
//  Concentration
//
//  Created by Yeh, Louis on 2018/1/16.
//  Copyright © 2018年 Yeh, Louis. All rights reserved.
//

import Foundation

struct Card
{
    var isFaceUp = false
    var wasMatched = false
    var wasFliped = false
    var identifier: Int
    private static var identifierFactory = 0
    
    private static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }
    
    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
}
