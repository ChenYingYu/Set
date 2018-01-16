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
    
    func chooseCard (at index: Int) {
            if let matchIndexOne = indexOfFirstCard, let matchIndexTwo = indexOfSecondCard, matchIndexOne != index, matchIndexTwo != index {
                // three card are selected, compare if "set"
                print("Ready to Set~")
                var checkSet = 0
                let firstCard = cards[matchIndexOne].condition
                let secondCard = cards[matchIndexTwo].condition
                let thirdCard = cards[index].condition
                for conditionIndex in 0..<firstCard.count {
                    if !(firstCard[conditionIndex] == secondCard[conditionIndex] && secondCard[conditionIndex] == thirdCard[conditionIndex]), !(firstCard[conditionIndex] != secondCard[conditionIndex] && secondCard[conditionIndex] != thirdCard[conditionIndex] && firstCard[conditionIndex] != thirdCard[conditionIndex]) {
                        print("Not Set~")
                        break
                    } else {
                        checkSet += 1
                    }
                }
                if checkSet == firstCard.count {
                    print("Seeeeeeeet~")
                    cards[index].condition.removeAll()
                    cards[matchIndexOne].condition.removeAll()
                    cards[matchIndexTwo].condition.removeAll()
                }
                indexOfFirstCard = nil
                indexOfSecondCard = nil
            } else {
                // deselection
                if indexOfFirstCard == index {
                    indexOfFirstCard = indexOfSecondCard
                    indexOfSecondCard =  nil
                } else if indexOfSecondCard == index {
                    indexOfSecondCard = nil
                }
                    // select first card, and deselect other
                else if indexOfFirstCard == nil {
                    indexOfFirstCard = index
                    for deselectIndex in cards.indices {
                        cards[deselectIndex].isSelected = false
                    }
                }   // select second card
                else {
                    indexOfSecondCard = index
                }
        }
        cards[index].isSelected = cards[index].isSelected == true ? false : true
        //print("First card: \(String(describing: indexOfFirstCard))\n Second card: \(String(describing: indexOfSecondCard))\n Chosen card: \(index)")
    }
    
    init(numberOfCards: Int) {
        for _ in 1...numberOfCards {
            let card = Card()
            cards += [card]
        }
    }
}
