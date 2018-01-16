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
    // there are four conditions
    var symbolChoices = ["●","▲","■","●●","▲▲","■■","●●●","▲▲▲","■■■"]
    
    var numberChoices = [1, 2, 3]
    
    var colorChoices = [#colorLiteral(red: 0.01680417731, green: 0.1983509958, blue: 1, alpha: 1), #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1), #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)]
    
    var shadingChoices = ["filled","striped","outline"]
    
    // record which patterns are chosen before
    var chosenBefore = [(Int, Int, Int, Int)]()

    @IBOutlet var cardButtons: [UIButton]! {
        didSet {
            assignCards()
        }
    }
    
    func assignCards() {
        for index in cardButtons.indices {
            if game.cards[index].condition.isEmpty {
                let button = cardButtons[index]
                // choose random conditions
                var randomSymbol = Int(arc4random_uniform(UInt32(symbolChoices.count)))
                var randomNumber = (randomSymbol / 3) + 1
                var randomColor = Int(arc4random_uniform(UInt32(colorChoices.count)))
                var randomShading = Int(arc4random_uniform(UInt32(shadingChoices.count)))
                // if the pattern is chosen before, choose again
                while chosenBefore.contains(where: {($0,$1,$2,$3) == (randomSymbol, randomNumber, randomColor, randomShading)}){
                    randomSymbol = Int(arc4random_uniform(UInt32(symbolChoices.count)))
                    randomNumber = (randomSymbol / 3) + 1
                    randomColor = Int(arc4random_uniform(UInt32(colorChoices.count)))
                    randomShading = Int(arc4random_uniform(UInt32(shadingChoices.count)))
                }
                // put symbol on the card
                if shadingChoices[randomShading] == "filled" { button.setAttributedTitle(NSAttributedString(string: symbolChoices[randomSymbol], attributes: [NSAttributedStringKey.foregroundColor: colorChoices[randomColor]]), for: UIControlState.normal)
                } else if shadingChoices[randomShading] == "striped" {
                    button.setAttributedTitle(NSAttributedString(string: symbolChoices[randomSymbol], attributes: [NSAttributedStringKey.foregroundColor: UIColor.withAlphaComponent(colorChoices[randomColor])(0.25)]), for: UIControlState.normal)
                } else if shadingChoices[randomShading] == "outline" {
                    button.setAttributedTitle(NSAttributedString(string: symbolChoices[randomSymbol], attributes: [NSAttributedStringKey.strokeColor: colorChoices[randomColor],NSAttributedStringKey.strokeWidth: 10]), for: UIControlState.normal)
                }
                
                // note this pattern is chosen before
                chosenBefore += [(randomSymbol, randomNumber, randomColor, randomShading)]
                print("\(chosenBefore.count)")
                // store conditions to model
                game.cards[index].condition = [randomSymbol % 3, randomNumber, randomColor, randomShading]
            }
        }
    }
    
    @IBAction func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.index(of: sender) {
            assignCards()
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            print("chosen card was not in cardButtons")
        }
    }
    
    func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isSelected == true {
                button.layer.borderWidth = 5.0
                button.layer.borderColor = #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)
                button.layer.cornerRadius = 8.0
            } else {
                button.layer.borderWidth = 0.0
            }
        }
    }
}


