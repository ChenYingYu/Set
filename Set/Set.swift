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
    
    var visibleCardDeck = [Card]()
    // get or lose points
    var countPoints = { a, b -> Int in a + b }
    
    var score = 0
    // use timer when v.s. com, it will pick a Set every 10 seconds
    var computeTimer = Timer()
    
    var computeCounter = 0.0

    // speed of play
    var startTime = Date()
    
    var endTime = Date()
    
    func timer() {
        endTime = Date()
        let timeInterval: Double = endTime.timeIntervalSince(startTime)
        switch timeInterval {
        case 0..<5.0:
            score = countPoints(score, 20)
        case 5.0..<10.0:
            score = countPoints(score, 10)
        default:
            score = countPoints(score, 0)
        }
        print("time: \(timeInterval)")
        startTime = Date()
    }
    // elect cards and check if set
    var checkSetPorperty = 0
    
    var selectedCardDeck = [Card]()
    
    var setCardDeck = [Card]()
    
    func chooseCard (at index: Int) {
        let chosenCard = cards[index]
        print("\(chosenCard.property)")
        if !(selectedCardDeck.contains { $0 == chosenCard }) {
            if selectedCardDeck.count == 3 {
                selectedCardDeck.removeAll()
            }
            selectedCardDeck.append(chosenCard)
            if selectedCardDeck.count == 3 {
                checkSetPorperty = 0
                let firstCard = selectedCardDeck[0].property
                let secondCard = selectedCardDeck[1].property
                let thirdCard = selectedCardDeck[2].property
                for compareIndex in 0...3 {
                    if !(firstCard[compareIndex] == secondCard[compareIndex] && secondCard[compareIndex] == thirdCard[compareIndex]), !(firstCard[compareIndex] != secondCard[compareIndex] && secondCard[compareIndex] != thirdCard[compareIndex] && firstCard[compareIndex] != thirdCard[compareIndex]) {
                        startTime = Date()
                        score = countPoints(score, -15)
                        break
                    } else {
                        checkSetPorperty += 1
                    }
                }
                // if make a Set
                if checkSetPorperty == 4 {
                    for index in cards.indices {
                        if selectedCardDeck.contains(where: { $0 == cards[index] }) {
                            setCardDeck.append(cards[index])
                            // remove set cards from visibleCardDeck
                            visibleCardDeck = visibleCardDeck.filter { $0 != cards[index] }
                            // remove their properties
                            cards[index].property.removeAll()
                        }
                    }
                    timer()
                    computeTimer.invalidate()
                    score = countPoints(score, 30)
                    selectedCardDeck.removeAll()
                }
            }
        } else {
            score = countPoints(score, -5)
            selectedCardDeck = selectedCardDeck.filter { $0 != chosenCard}
        }
    }
    
    //check if there exists a visible Set
    var h = 0, m = 1, l = 2, times = 0
    
    func checkOut() {
        if !setCardDeck.isEmpty {
            score = countPoints(score, -25)
        }
    }
    
    func removeSetCardProperty() {
        for index in cards.indices {
            if setCardDeck.contains(where: { $0 == cards[index] }) {
                visibleCardDeck = visibleCardDeck.filter { $0 != cards[index]}
                cards[index].property.removeAll()
            }
        }
    }
    
    func checkIfExistSet() {
        while h < visibleCardDeck.count - 2 {
            while m < visibleCardDeck.count - 1 {
                while l < visibleCardDeck.count {
                    let firstCard = visibleCardDeck[h]
                    let secondCard = visibleCardDeck[m]
                    let thirdCard = visibleCardDeck[l]
                    for compareIndex in 0...3 {
                        times += 1
                        // misMatch
                        if !(firstCard.property[compareIndex] == secondCard.property[compareIndex] && secondCard.property[compareIndex] == thirdCard.property[compareIndex]), !(firstCard.property[compareIndex] != secondCard.property[compareIndex] && secondCard.property[compareIndex] != thirdCard.property[compareIndex] && firstCard.property[compareIndex] != thirdCard.property[compareIndex]) {
                            break
                        } else {
                            checkSetPorperty += 1
                        }
                    }
                    if checkSetPorperty == 4 {
                        print("Has a visible Set")
                        print("Compare times: \(times)\n 1st: \(firstCard)\n 2nd: \(secondCard)\n 3rd: \(thirdCard)")
                        setCardDeck += [firstCard, secondCard, thirdCard]
                        h = 0
                        m = 1
                        l = 2
                        times = 0
                        checkSetPorperty = 0
                        return
                    }
                    checkSetPorperty = 0
                    l += 1
                }
                m += 1
                l = m + 1
            }
            h += 1
            m = h + 1
            l = m + 1
        }
        h = 0
        m = 1
        l = 2
        times = 0
    }
    
    init(numberOfCards: Int) {
        for _ in 1...numberOfCards {
            let card = Card()
            cards += [card]
        }
    }
}

extension Card: Equatable {
    static func ==(lhs: Card, rhs: Card) -> Bool {
        return lhs.property == rhs.property
    }
    
}
