//
//  ViewController.swift
//  Concentration
//
//  Created by Артем Соловьев on 25.07.2021.
//

import UIKit

class ViewController: UIViewController {

    private lazy var game = ConcentrationGame(numberOfPairsCards: numberOfPairsCards)
    
    var numberOfPairsCards: Int {
        return (buttonCollection.count + 1) / 2
    }
    
    private(set) var touches = 0{
        didSet{
            touchLabel.text = "Touches: \(touches)"
        }
    }
    
    private var emojiCollection = ["🦊","🐰","🦋","🐔","🐹","🦎","🐠","🐷"]
    
    private var emojiDictionary = [Int:String]()
    
    private func emojiIdentifier(for card: Card) -> String {
        if emojiDictionary[card.identifier] == nil {
            emojiDictionary[card.identifier] = emojiCollection.remove(at: emojiCollection.count.arch4randomExtension)
        }
        return emojiDictionary[card.identifier] ?? "?"
    }
    
    private func updateViewFromModel() {
        for index in buttonCollection.indices {
            let button = buttonCollection[index]
            let card = game.cards[index]
            if card.isFaceUp{
                button.setTitle(emojiIdentifier(for: card), for: .normal)
                button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                
            } else{
                button.setTitle("", for: .normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0) : #colorLiteral(red: 0, green: 0.4677700996, blue: 0.9209138751, alpha: 1)
            }
            
        }
    }
    
    @IBOutlet private var buttonCollection: [UIButton]!
    @IBOutlet private weak var touchLabel: UILabel!
    @IBAction private func buttonAction(_ sender: UIButton) {
        touches += 1
        if let buttonIndex = buttonCollection.firstIndex(of: sender){
            game.chooseCard(at: buttonIndex)
            updateViewFromModel()
        }
    }
}

extension Int{
    var arch4randomExtension: Int {
        if self > 0{
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0{
            return -Int(arc4random_uniform(UInt32(abs(self))))
        } else{
            return 0
        }
    }
}
