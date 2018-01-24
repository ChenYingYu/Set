//
//  ViewController.swift
//  Set
//
//  Created by ChenAlan on 2018/1/5.
//  Copyright © 2018年 ChenAlan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    lazy var game = Set(numberOfCards: cardButtons.count)

    // record which patterns are chosen before
    @IBOutlet var cardButtons: [UIButton]! {
        didSet {
            assignProperty()
        }
    }
    
    var visibleCards = 12
    var cardDeck = Card().cardDeck
    func assignProperty() {
        for index in cardButtons.indices {
            if game.cards[index].property.isEmpty, index < visibleCards, game.visibleCardDeck.count < 81 {
                game.cards[index].isSelected = false
                let button = cardButtons[index]
                let randomPropertyIndex = cardDeck.count.arc4random
                let cardProperty = cardDeck.remove(at: randomPropertyIndex)
                let cardSymbol = cardProperty.0,numberOfSymbol = String(cardProperty.0.count), cardSymbolColor = cardProperty.1, cardSymbolStyle = cardProperty.2
                
                var symbolColor = #colorLiteral(red: 0.01680417731, green: 0.1983509958, blue: 1, alpha: 1)
                switch cardSymbolColor {
                case "blue": symbolColor = #colorLiteral(red: 0.01680417731, green: 0.1983509958, blue: 1, alpha: 1)
                case "green": symbolColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
                case "red": symbolColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
                default: return
                }

                // put symbol on the card
                if cardSymbolStyle == "filled" { button.setAttributedTitle(NSAttributedString(string: cardSymbol, attributes: [NSAttributedStringKey.foregroundColor: symbolColor]), for: UIControlState.normal)
                } else if cardSymbolStyle == "shade" {
                    button.setAttributedTitle(NSAttributedString(string: cardSymbol, attributes: [NSAttributedStringKey.foregroundColor: UIColor.withAlphaComponent(symbolColor)(0.25)]), for: UIControlState.normal)
                } else if cardSymbolStyle == "outline" {
                    button.setAttributedTitle(NSAttributedString(string: cardSymbol, attributes: [NSAttributedStringKey.strokeColor: symbolColor,NSAttributedStringKey.strokeWidth: 10]), for: UIControlState.normal)
                }
                
                let symbol = String(cardSymbol[cardSymbol.startIndex])
                
                // note this pattern is chosen before
                game.visibleCardDeck += [[symbol, numberOfSymbol, cardSymbolColor, cardSymbolStyle]]
                // store card's properties to model
                game.cards[index].property = [symbol, numberOfSymbol, cardSymbolColor, cardSymbolStyle]
            } else if game.cards[index].property.isEmpty {
                cardButtons[index].backgroundColor = #colorLiteral(red: 0, green: 0.9914394021, blue: 1, alpha: 1)
                cardButtons[index].setAttributedTitle(NSAttributedString(string: ""), for: UIControlState.normal)
            }
        }
    }
    
    @IBAction func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.index(of: sender) {
            if cardNumber < visibleCards, !game.cards[cardNumber].property.isEmpty {
                assignProperty()
                game.chooseCard(at: cardNumber)
                updateViewFromModel()
            }
        } else {
            print("chosen card was not in cardButtons")
        }
    }
    
    func addCards() {
        for index in cardButtons.indices {
            // if we got set, replace those cards wth new three cards
            if game.cards[index].property.isEmpty, index < visibleCards {
                game.checkIfExistSet()
                assignProperty()
                updateViewFromModel()
                print("\(game.visibleCardDeck)")
                return
            }
        }
        // or we add three new cards
        if visibleCards < 24 {
            game.checkIfExistSet()
            for _ in 0..<3 {
                cardButtons[visibleCards].backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                visibleCards += 1
            }
            assignProperty()
            updateViewFromModel()
        } else {
            print("can not add more cards")
        }
    }
    
    @IBAction func addCardsButton(_ sender: UIButton) {
        addCards()
    }
    
    @IBAction func hintButton(_ sender: UIButton) {
        game.checkIfExistSet()
        game.giveHint()
        updateViewFromModel()
    }
    
    @IBAction func newGameButton(_ sender: UIButton) {
        visibleCards = 12
        game.score = 0
        scoreLabel.text = "Score: \(game.score)"
        cardDeck = Card().cardDeck
        game.visibleCardDeck.removeAll()
        for index in cardButtons.indices {
            let button = cardButtons[index]
            var card = game.cards[index]
            button.layer.borderWidth = 0.0
            card.isSelected = false
            card.set = false
            game.cards[index].property.removeAll()
            cardButtons[index].setAttributedTitle(NSAttributedString(string: ""), for: UIControlState.normal)
            cardButtons[index].backgroundColor = index < visibleCards ? #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0) : #colorLiteral(red: 0, green: 0.9914394021, blue: 1, alpha: 1)
        }
        assignProperty()
        game.indexOfFirstCard = nil
        game.indexOfSecondCard = nil
    }
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isSelected == true {
                if card.set == true {
                    button.layer.borderWidth = 6.0
                    button.layer.borderColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
                    button.layer.cornerRadius = 8.0
                    game.cards[index].set = false
                } else {
                    button.layer.borderWidth = 5.0
                    button.layer.borderColor = #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)
                    button.layer.cornerRadius = 8.0
                }
            } else {
                button.layer.borderWidth = 0.0
            }
        }
        scoreLabel.text = "Score: \(game.score)"
    }
}

extension Int {
    var arc4random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0{
            return -Int(arc4random_uniform(UInt32(abs(self))))
        } else {
            return 0
        }
    }
}
