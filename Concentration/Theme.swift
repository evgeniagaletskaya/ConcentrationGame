//
//  Theme.swift
//  Concentration
//
//  Created by Evgenia Galetskaya on 9/27/18.
//  Copyright © 2018 Evgenia Galetskaya. All rights reserved.
//

import UIKit

struct Theme {
    var backgroundColor: UIColor
    var cardsColor: UIColor
    var cardsTitles: [String]
    var themeName: String
    
    init(backgroundColor: UIColor, cardsColor: UIColor, cardsTitles: [String], themeName: String){
        self.backgroundColor = backgroundColor
        self.cardsColor = cardsColor
        self.cardsTitles = cardsTitles
        self.themeName = themeName
    }
    
}
