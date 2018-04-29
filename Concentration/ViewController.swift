//
//  ViewController.swift
//  Concentration
//
//  Created by Yeh, Louis on 2018/1/15.
//  Copyright © 2018年 Yeh, Louis. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private var themes = [
        ["😀", "😃", "😄", "😁", "🤣", "😂", "😅", "😆", "☺️", "😊"],
        ["🐶", "🐰", "🐨", "🐷", "🙈", "🐔", "🐣", "🐥", "🐧", "🐦"],
        ["🥑", "🌽", "🌶", "🥐", "🍠", "🥨", "🥚", "🍳", "🥖", "🍔"],
        ["⚾️", "🏈", "🏀", "⚽️", "🎾", "🏐", "🏉", "🏒", "🥅", "🎱"],
        ["🚙", "🚓", "🚚", "🚐", "🚒", "🚜", "🛴", "🚨", "🏍", "🚔"],
        ["㊙️", "🉐", "🈵", "🅱️", "🆎", "🆑", "🅾️", "🅰️", "🈲", "🆘"]
    ]
    var newEmojiSet: [String] {
        get {
            let randomIndex = Int(arc4random_uniform(UInt32(themes.count)))
            return themes[randomIndex]
        }
    }
    var emoji = [Int:String]()
    lazy var game = Concentration(numberOfCards: cardButtons.count)
    lazy var emojiChoises = newEmojiSet

    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var flipCountLabel: UILabel!
    @IBOutlet var cardButtons: [UIButton]!
    @IBAction func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.index(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            print("chosen a card which is not inside cardButtons")
        }
    }
    
    @IBAction func touchNewGame(_ sender: UIButton) {
        resetGame()
        updateViewFromModel()
    }
    
    private func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControlState.normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            } else {
                button.setTitle("", for: UIControlState.normal)
                button.backgroundColor = card.wasMatched ? #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0) : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
            }
        }

        // update labels
        flipCountLabel.text = "Flips: \(game.flipsCounter)"
        scoreLabel.text = "Score: \(game.score)"
    }
    
    private func emoji(for card: Card) -> String {
        if emoji[card.identifier] == nil, emojiChoises.count > 0 {
            let randomIndex = Int(arc4random_uniform(UInt32(emojiChoises.count)))
            emoji[card.identifier] = emojiChoises.remove(at: randomIndex)
        }
        return emoji[card.identifier] ?? "?"
    }
    
    private func resetGame() {
        game = Concentration(numberOfCards: cardButtons.count)
        emojiChoises = newEmojiSet
        emoji = [Int:String]()
    }

}
