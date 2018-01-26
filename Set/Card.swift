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
    var property = [String]()
    var cardDeck = [(String, String, String)]()
    
    enum Symbol: String {
        case circle = "●"
        case triangle = "▲"
        case square = "■"
        case twoCircle = "●●"
        case twoTriangle = "▲▲"
        case twoSquare = "■■"
        case threeCircle = "●●●"
        case threeTriangle = "▲▲▲"
        case threeSquare = "■■■"
        
        static var all = [Symbol.circle,.triangle,.square,.twoCircle,.twoTriangle,.twoSquare,.threeCircle,.threeTriangle,.threeSquare]
    }
    
    enum Number: String {
        case one = "1"
        case two = "2"
        case three = "3"
        
        static var all = [Number.one,.two,.three]
    }
    
    enum Color: String {
        case blue = "blue"
        case green = "green"
        case red = "red"
        
        static var all = [Color.blue,.green,.red]
    }
    
    enum Shade: String {
        case filled = "filled"
        case shade = "shade"
        case outline = "outline"
        
        static var all = [Shade.filled,.shade,.outline]
    }
    
    init() {
        for symbol in Symbol.all {
            for color in Color.all {
                for shade in Shade.all {
                    cardDeck.append((symbol.rawValue,color.rawValue,shade.rawValue))
                }
            }

        }
    }
}
