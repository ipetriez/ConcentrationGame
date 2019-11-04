//
//  ViewController.swift
//  ConcentrationGame (Stanford University)
//
//  Created by Sergey Petrosyan on 7/20/19.
//  Copyright © 2019 Sergey Petrosyan. All rights reserved.
//

import UIKit

class ConcentrationViewController: UIViewController {

    @IBAction func startNewGame(_ sender: UIButton) {
        //emoji = [:]
        //emojiChoices = Theme.allCases.randomElement()!.rawValue
        game.startNewGame()
        //emojiChoices = Theme.allCases.randomElement()!.rawValue
        flipCount = 0
        updateViewFromModel()
    }
    
    @IBOutlet private weak var flipsCountLabel: UILabel! {
        didSet {
            updateFlipcountLabel()
        }
    }
    
    @IBOutlet private var cardButtons: [UIButton]!
    
    @IBAction private func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.firstIndex(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
            if game.cards[cardNumber].isMatched == false {
                flipCount += 1
            }
        } else {
            print("Error in @IBAction func touchCard(_ sender: UIButton).")
        }
    }
    
    
    private lazy var game = ConcentrationModel(numberOfPairsOfCards: numberOfPairsOfCards)
    var numberOfPairsOfCards: Int {
        return (cardButtons.count + 1) / 2
    }
    
    private(set) var flipCount = 0 {
        didSet {
            updateFlipcountLabel()
        }
    }
    
    
    private func updateFlipcountLabel() {
        let attributes: [NSAttributedString.Key:Any] = [
            .strokeWidth : 5.0,
            .strokeColor : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
        ]
        let attributedString = NSAttributedString(string: "Flips \(flipCount)", attributes: attributes)
        flipsCountLabel.attributedText = attributedString
    }
    
    
    private func updateViewFromModel() {
        if cardButtons != nil {
            for index in cardButtons.indices {
                let button = cardButtons[index]
                let card = game.cards[index]
                if card.isFaceUp {
                    button.setTitle(emoji(for: card), for: UIControl.State.normal)
                    button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                } else {
                    button.setTitle("", for: UIControl.State.normal)
                    button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0) : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
                }
            }
        }
    }
    
    var theme: String? {
        didSet {
            emojiChoices = theme ?? ""
            emoji = [:]
            updateViewFromModel()
        }
    }
    
    

    private var emojiChoices = ""
    private var emoji = [Card:String]()
    
    
    private func emoji(for card: Card) -> String {
        if emoji[card] == nil, emojiChoices.count > 0 {
            let randomIndex = emojiChoices.index(emojiChoices.startIndex, offsetBy: emojiChoices.count.arc4random)
            emoji[card] = String(emojiChoices.remove(at: randomIndex))
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
        } else {
            return 0
        }
    }
}
