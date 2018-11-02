//
//  ViewController.swift
//  Concentration
//
//  Created by Evgenia Galetskaya on 9/25/18.
//  Copyright © 2018 Evgenia Galetskaya. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet private weak var flipCountLabel: UILabel!
    @IBOutlet private weak var newGameButton: UIButton!
    @IBOutlet private var cardButtons: [UIButton]!
    @IBOutlet private weak var scoreLabel: UILabel!
    
    var numberOfPairsOfCards: Int {
        return (cardButtons.count + 1) / 2
    }
    
    private lazy var game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
    
    private(set) var flipCount = 0 { didSet { flipCountLabel.text = "Flips: \(flipCount)" }}
    

    var themeBackgroundColor: UIColor?
    var themeCardColor: UIColor?
    var themeCardsTitles:[String]?
    var emoji = [Card:String]()
    
    
    private let halloweenTheme = Theme(backgroundColor: #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1), cardsColor: #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1), cardsTitles:["👻","🎃","🦇","🕷","🙀","😱","🦉","🕸","😈"],themeName: "Halloween")
    private let foodTheme = Theme(backgroundColor: #colorLiteral(red: 0.8896309217, green: 0.9994240403, blue: 0.5852657947, alpha: 1), cardsColor: #colorLiteral(red: 1, green: 0.4663034406, blue: 0.3906085908, alpha: 0.5), cardsTitles: ["🍔","🍟","🌭","🍖","🌮","🥙","🍕","🌯","🍝"],themeName:"Food")
    private let facesTheme = Theme(backgroundColor: #colorLiteral(red: 0.8413153565, green: 0.812424611, blue: 1, alpha: 1), cardsColor: #colorLiteral(red: 0.3283356123, green: 0.8103889622, blue: 0.8673461294, alpha: 1), cardsTitles: ["😽","😁","😅","😂","😇","😍","🤓","🤪","🤩"], themeName: "Emojis")
    private let animalsTheme = Theme(backgroundColor: #colorLiteral(red: 0.9098039269, green: 0.7082269457, blue: 0.8113403086, alpha: 1), cardsColor: #colorLiteral(red: 0.8454428007, green: 1, blue: 0.6723050432, alpha: 1), cardsTitles: ["🐶","🐱","🐭","🐷","🙉","🐥","🐴","🐨","🦊"], themeName: "Animals")
    private let countriesTheme = Theme(backgroundColor: #colorLiteral(red: 0.9613144039, green: 1, blue: 0.3816806274, alpha: 1), cardsColor: #colorLiteral(red: 0.7539932341, green: 0.6711825806, blue: 0.8065315673, alpha: 1), cardsTitles: ["🇯🇵","🇫🇷","🇨🇿","🇲🇨","🇷🇺","🇺🇦","🇺🇸","🇹🇷","🇮🇹"], themeName: "Countries")
    private let sportsTheme = Theme(backgroundColor: #colorLiteral(red: 0.521568656, green: 0.1098039225, blue: 0.05098039284, alpha: 1), cardsColor: #colorLiteral(red: 1, green: 0.9046518281, blue: 0.6567809878, alpha: 1), cardsTitles: ["⚽️","🏀","🏓","🥊","⛷","🏊‍♂️","🚴‍♀️","🏒","🎱"], themeName: "Sports")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTheme()
        updateViewFromModel()
    }
    
    @IBAction private func startNewGame(_ sender: UIButton) {
        newGameButton.isEnabled = false
        flipCount = 0
        game.score = 0
        game.resetCards()
        emoji.removeAll()
        game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
        setTheme()
        updateViewFromModel()
    }
    
    private func  setTheme(){
        
        let themes = [halloweenTheme,foodTheme,facesTheme,animalsTheme,countriesTheme,sportsTheme]
        let randomTheme = themes.count.arc4random
        themeBackgroundColor = themes[randomTheme].backgroundColor
        themeCardColor = themes[randomTheme].cardsColor
        themeCardsTitles = themes[randomTheme].cardsTitles
        view.backgroundColor = themeBackgroundColor
        flipCountLabel.textColor = themeCardColor
        flipCountLabel.shadowColor = UIColor.white
        scoreLabel.textColor = themeCardColor
        configureCardsView()
        
    }
    
    private func configureCardsView() {
        
        for cardButton in cardButtons {
            cardButton.layer.borderWidth = 3
            cardButton.layer.borderColor = UIColor.lightGray.cgColor
            cardButton.layer.cornerRadius = 5
        }
    }
   
    @IBAction private func touchCard(_ sender: UIButton) {
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
    
    private func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControl.State.normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            } else {
                button.setTitle("", for: UIControl.State.normal)
                button.layer.borderWidth = 0
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0) : themeCardColor
            }
        }
    }
    
    private func emoji(for card: Card) -> String {
        if emoji[card] == nil && themeCardsTitles!.count > 0 {
            emoji[card] = themeCardsTitles!.remove(at: themeCardsTitles!.count.arc4random)
        
        }
        return emoji[card] ?? "?"
    }
}

extension Int {
    var arc4random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        }
        else {
            return 0
        }
    }
}

