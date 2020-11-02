//
//  ViewController.swift
//  Hangman Game
//
//  Created by John Padilla on 10/30/20.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var hangmanImageView: UIImageView!
    @IBOutlet weak var correctWordLabel: UILabel!
    @IBOutlet weak var scorerLabel: UILabel!
    @IBOutlet var letterButtons: [UIButton]!
    
    var currentGame: Game!
    var listOfWords = ["buccaneer", "swift", "glorious", "incandescent", "bug", "program"]
    let incorrectMovesAllowed = 7
    var totalWins = 0 {
        didSet {
            newRound()
        }
    }
    
    var totalLosses = 0 {
        didSet {
            newRound()
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        newRound()
        updateUI()
    }
    
    func newRound() {
        if !listOfWords.isEmpty {
            let newWord = listOfWords.removeFirst()
            currentGame = Game(word: newWord, incorrectMoveRemaing: incorrectMovesAllowed, guessedLetters: [])
            enableLetterButtons(true)
        } else {
            enableLetterButtons(false)
        }
    }
    
    func enableLetterButtons(_ enable: Bool) {
        for button in letterButtons {
            button.isEnabled = enable
        }
    }
    
    func updateUI() {
        var letters = [String]()
        for letter in currentGame.formattedWord {
            letters.append(String(letter))
        }
        
        let wordWithSpacing = letters.joined(separator: " ")
        correctWordLabel.text = wordWithSpacing
        scorerLabel.text = "Wins: \(totalWins), Losses: \(totalLosses)"
        hangmanImageView.image = UIImage(named: "han \(currentGame.incorrectMoveRemaing)")
    }
    
    func updateGameStats() {
        if currentGame.incorrectMoveRemaing == 0 {
            let ac = UIAlertController(title: "Oops!", message: "You got this?", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Let's go!", style: .default, handler: nil))
            present(ac, animated: true)
            totalLosses += 1
            updateUI()
            
        } else if currentGame.word == currentGame.formattedWord {
            
            let ac = UIAlertController(title: "Well done!", message: "Are you ready for the next label?", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Let's go!", style: .default, handler: nil))
            present(ac, animated: true)
            totalWins += 1
            updateUI()

        } else {
            updateUI()
        }
    }

    @IBAction func letterButtonPressed(_ sender: UIButton) {
        
        sender.isEnabled = false
        let letterString = sender.title(for: .normal)!
        let letter = Character(letterString.lowercased())
        currentGame.playerGuessed(letter: letter)
        updateGameStats()
    }
}
