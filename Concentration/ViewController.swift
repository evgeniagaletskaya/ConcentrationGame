//
//  ViewController.swift
//  Concentration
//
//  Created by Evgenia Galetskaya on 9/25/18.
//  Copyright © 2018 Evgenia Galetskaya. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var themeLabel: UILabel!
    @IBOutlet weak var flipCountLabel: UILabel!
    @IBOutlet weak var newGameButton: UIButton!
    @IBOutlet var cardButtons: [UIButton]!
    @IBOutlet weak var scoreLabel: UILabel!
    
    var numberOfPairsOfCards: Int {
        return (cardButtons.count + 1) / 2
    }
    
    lazy var game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
    
    var flipCount = 0 { didSet { flipCountLabel.text = "Flips: \(flipCount)" }}
    

    var themeBackgroundColor: UIColor?
    var themeCardColor: UIColor?
    var themeCardsTitles:[String]?
    var emoji = [Int:String]()
    
    
    let halloweenTheme = Theme(backgroundColor: #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1), cardsColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), cardsTitles:["👻","🎃","🦇","🕷","🙀","😱","🦉","🕸","😈"],themeName: "Halloween")
    let foodTheme = Theme(backgroundColor: #colorLiteral(red: 0.786917193, green: 0.9994240403, blue: 0.4038903533, alpha: 1), cardsColor: #colorLiteral(red: 1, green: 0.4663034406, blue: 0.3906085908, alpha: 0.7972495719), cardsTitles: ["🍔","🍟","🌭","🍖","🌮","🥙","🍕","🌯","🍝"],themeName:"Food")
    let facesTheme = Theme(backgroundColor: #colorLiteral(red: 0.7214492374, green: 0.7381138519, blue: 1, alpha: 0.8630672089), cardsColor: #colorLiteral(red: 0.3861006714, green: 0.9357633932, blue: 1, alpha: 1), cardsTitles: ["😽","😁","😅","😂","😇","😍","🤓","🤪","🤩"], themeName: "Emojis")
    let animalsTheme = Theme(backgroundColor: #colorLiteral(red: 1, green: 0.7259366195, blue: 0.8889133281, alpha: 1), cardsColor: #colorLiteral(red: 0.8454428007, green: 1, blue: 0.6723050432, alpha: 1), cardsTitles: ["🐶","🐱","🐭","🐷","🙉","🐥","🐴","🐨","🦊"], themeName: "Animals")
    let countriesTheme = Theme(backgroundColor: #colorLiteral(red: 1, green: 0.9779360792, blue: 0.6165053726, alpha: 1), cardsColor: #colorLiteral(red: 0.7539932341, green: 0.6711825806, blue: 0.8065315673, alpha: 1), cardsTitles: ["🇯🇵","🇫🇷","🇨🇿","🇲🇨","🇷🇺","🇺🇦","🇺🇸","🇹🇷","🇮🇹"], themeName: "Countries")
    let sportsTheme = Theme(backgroundColor: #colorLiteral(red: 0.521568656, green: 0.1098039225, blue: 0.05098039284, alpha: 1), cardsColor: #colorLiteral(red: 0.9935016384, green: 0.8463995151, blue: 0.2456219637, alpha: 0.8256367723), cardsTitles: ["⚽️","🏀","🏓","🥊","⛷","🏊‍♂️","🚴‍♀️","🏒","🎱"], themeName: "Sports")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTheme()
        updateViewFromModel()
    }
    
    @IBAction func startNewGame(_ sender: UIButton) {
        newGameButton.isEnabled = false
        flipCount = 0
        game.score = 0
        game.resetCards()
        emoji.removeAll()
        game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
        setTheme()
        updateViewFromModel()
    }
    
    func setTheme(){
        let themes = [halloweenTheme,foodTheme,facesTheme,animalsTheme,countriesTheme,sportsTheme]
        let randomTheme = Int(arc4random_uniform(UInt32(themes.count)))
        let themeName = themes[randomTheme].themeName
        themeBackgroundColor = themes[randomTheme].backgroundColor
        themeCardColor = themes[randomTheme].cardsColor
        themeCardsTitles = themes[randomTheme].cardsTitles
        self.view.backgroundColor = themeBackgroundColor
        flipCountLabel.textColor = themeCardColor
        flipCountLabel.shadowColor = UIColor.white
        themeLabel.text = themeName
        themeLabel.textColor = themeCardColor
        themeLabel.shadowColor = UIColor.white
        scoreLabel.textColor = themeCardColor
    }
   
    @IBAction func touchCard(_ sender: UIButton) {
        newGameButton.isEnabled = true
        flipCount += 1
        if let cardNumber = cardButtons.index(of: sender){
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
            scoreLabel.text = "Score: \(game.score)"
        } else {
            print("chosen card was not in cardButtons")
        }
    }
    
    func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControl.State.normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            } else {
                button.setTitle("", for: UIControl.State.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0) : themeCardColor
            }
        }
    }
    
    func emoji(for card: Card) -> String {
        if emoji[card.identifier] == nil, themeCardsTitles!.count > 0 {
            let randomIndex = Int(arc4random_uniform(UInt32(themeCardsTitles!.count - 1)))
            emoji[card.identifier] = themeCardsTitles!.remove(at: randomIndex)
        
        }
        return emoji[card.identifier] ?? "?"
    }
}

