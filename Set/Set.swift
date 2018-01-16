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

    //var matchIndexOne = 0
    
    //var matchIndexTwo = 0
    
    func chooseCard (at index: Int) {
        // two cards are select, rady to m
            if let matchIndexOne = indexOfFirstCard, let matchIndexTwo = indexOfSecondCard, matchIndexOne != index, matchIndexTwo != index {
                // three card are selected, compare if "set"
                print("Ready to Set~")
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
        print("First card: \(String(describing: indexOfFirstCard))\n Second card: \(String(describing: indexOfSecondCard))\n Chosen card: \(index)")
    }
    
    init(numberOfCards: Int) {
        for _ in 1...numberOfCards {
            let card = Card()
            cards += [card]
        }
    }
}
