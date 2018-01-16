//
//  Card.swift
//  Set
//
//  Created by ChenAlan on 2018/1/5.
//  Copyright © 2018年 ChenAlan. All rights reserved.
//

import Foundation

struct Card
{
//    var hashValue: Int { return identifier }
//
//    static func == (firstCard: Card, secondCard: Card) -> Bool {
//        return firstCard.identifier == secondCard.identifier
//    }
    
    var isSelected = false
    var isMatched = false
    var identifier: Int
    var condition = [Int]()
    
    static var identifierCount = 0
    
    static func getUniqueIdentifier () -> Int{
        identifierCount += 1
        return identifierCount
    }
    
    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
    
}
