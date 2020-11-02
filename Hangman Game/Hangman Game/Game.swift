//
//  Game.swift
//  Hangman Game
//
//  Created by John Padilla on 10/30/20.
//

import Foundation

struct Game {
    var word: String
    var incorrectMoveRemaing: Int
    var guessedLetters: [Character]
    
    var formattedWord: String {
        var guessedWord = ""
        for letter in word {
            if guessedLetters.contains(letter) {
                guessedWord += "\(letter)"
            } else {
                guessedWord += "_"
            }
        }
        return guessedWord
    }
    
    mutating func playerGuessed(letter: Character) {
        guessedLetters.append(letter)
        
        if !word.contains(letter) {
            incorrectMoveRemaing -= 1
        }
    }
}
