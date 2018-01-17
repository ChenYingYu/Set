//
//  Set.swift
//  Set
//
//  Created by ChenAlan on 2018/1/13.
//  Copyright © 2018年 ChenAlan. All rights reserved.
//

import Foundation

class Set {
    var cards = [Card]()
    
    var indexOfFirstCard: Int?
    
    var indexOfSecondCard: Int?
    
    var usedCombination = [(Int, Int, Int, Int)]()
    
    func chooseCard (at index: Int) {
            if let matchIndexOne = indexOfFirstCard, let matchIndexTwo = indexOfSecondCard, matchIndexOne != index, matchIndexTwo != index {
                // check if three cards form a "Set"
                var checkSetPorperty = 0
                let firstCard = cards[matchIndexOne].property
                let secondCard = cards[matchIndexTwo].property
                let thirdCard = cards[index].property
                // check four properties
                for propertyIndex in 0..<firstCard.count {
                    if !(firstCard[propertyIndex] == secondCard[propertyIndex] && secondCard[propertyIndex] == thirdCard[propertyIndex]), !(firstCard[propertyIndex] != secondCard[propertyIndex] && secondCard[propertyIndex] != thirdCard[propertyIndex] && firstCard[propertyIndex] != thirdCard[propertyIndex]) {
                        break
                    } else {
                        checkSetPorperty += 1
                    }
                }
                if checkSetPorperty == firstCard.count {
                    cards[index].set = true
                    cards[matchIndexOne].set = true
                    cards[matchIndexTwo].set = true
                    cards[index].property.removeAll()
                    cards[matchIndexOne].property.removeAll()
                    cards[matchIndexTwo].property.removeAll()
                }
                indexOfFirstCard = nil
                indexOfSecondCard = nil
            } else {
                // deselection
                if indexOfFirstCard == index {
                    // deselect first card
                    indexOfFirstCard = indexOfSecondCard
                    indexOfSecondCard =  nil
                } else if indexOfSecondCard == index {
                    // deselect second card
                    indexOfSecondCard = nil
                } else if indexOfFirstCard == nil {
                    indexOfFirstCard = index
                    // deselect all cards
                    for deselectIndex in cards.indices {
                        cards[deselectIndex].isSelected = false
                    }
                } else {
                    // select second card
                    indexOfSecondCard = index
                }
        }
        cards[index].isSelected = cards[index].isSelected == true ? false : true
    }
    
    init(numberOfCards: Int) {
        for _ in 1...numberOfCards {
            let card = Card()
            cards += [card]
        }
    }
}
