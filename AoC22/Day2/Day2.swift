//
//  Day2.swift
//  AoC22
//
//  Created by Tobias Lachermeier on 06.12.22.
//

import Foundation

enum Symbol: Int {
    case rock = 1
    case paper = 2
    case sis = 3
    case unknown = 0
    
    static func from(_ string: String) -> Symbol {
        switch string {
        case "A", "X": return .rock
        case "B", "Y": return .paper
        case "C", "Z": return .sis
        default: return .unknown
        }
    }
    
    /*
     X means you need to lose, Y means you need to end the round in a draw, and Z means you need to win. Good luck!"
     */
    
    static func from(first: Symbol, second: String) -> Symbol {
        switch (first, second) {
        case (.rock, "X"): return .sis
        case (.rock, "Y"): return .rock
        case (.rock, "Z"): return .paper
            
        case (.paper, "X"): return .rock
        case (.paper, "Y"): return .paper
        case (.paper, "Z"): return .sis
            
        case (.sis, "X"): return .paper
        case (.sis, "Y"): return .sis
        case (.sis, "Z"): return .rock
        
        default: return .unknown
        }
    }
}

struct Game {

    let won: Int = 6
    let draw: Int = 3
    let loss = 0
    
    let player1: Symbol
    let player2: Symbol
    
    static func first(input: String) -> Game {
        let array = input.trimmingCharacters(in: .whitespacesAndNewlines).split(separator: " ")
        return Game(player1: Symbol.from(String(array[0])), player2:  Symbol.from(String(array[1])))
    }
    
    static func second(input: String) -> Game {
        let array = input.trimmingCharacters(in: .whitespacesAndNewlines).split(separator: " ")
        let player1 = Symbol.from(String(array[0]))
        return Game(player1: player1, player2: Symbol.from(first: player1, second: String(array[1])))
    }
    
    func scores() -> Int {
        /*
         Then, a winner for that round is selected:
         Rock defeats Scissors,
         Scissors defeats Paper,
         and Paper defeats Rock.
         If both players choose the same shape, the round instead ends in a draw.
         
         */
        var score = 0
        
        switch (player2, player1) {
        case (.rock, .paper): score = loss
        case (.rock, .sis): score = won
        case (.rock, .rock): score = draw
            
        case (.paper, .paper): score = draw
        case (.paper, .sis): score = loss
        case (.paper, .rock): score = won
            
        case (.sis, .paper): score = won
        case (.sis, .sis): score = draw
        case (.sis, .rock): score = loss
        default: score = 0
        }
        
        return score + player2.rawValue
    }
}

class Day2: Day {
    var day: Int = 2
    
    func solveFirstQuiz() {
        let input = loadFirstInput()
        var score = 0
        for line in input {
            let game = Game.first(input: line)
            score += game.scores()
        }
        print(score)
    }
    
    func solveSecondQuiz() {
        let input = loadFirstInput()
        var score = 0
        for line in input {
            let game = Game.second(input: line)
            score += game.scores()
        }
        print(score)
    }
}
