//
//  Against.swift
//  Set
//
//  Created by ChenAlan on 2018/1/26.
//  Copyright © 2018年 ChenAlan. All rights reserved.
//

import Foundation

struct Against
{
    
    // use timer when v.s. com, it will pick a Set every 10 seconds
    var computeTimer = Timer()
    
    var computeCounter = 0.0
    
    var emojiChoices = [String]()
    
    enum Emoji: String {
        case thinking = "🤔"
        case ready = "😏"
        case pickUp = "😁"
        case shock = "😱"
        
        static var all = [Emoji.thinking,.ready,.pickUp,.shock]
    }
    
    init() {
        for emoji in Emoji.all {
            emojiChoices.append(emoji.rawValue)
        }
    }
    
}
