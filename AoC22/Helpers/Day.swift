//
//  Day.swift
//  AoC22
//
//  Created by Tobias Lachermeier on 06.12.22.
//

import Foundation

protocol Day {
    var day: Int { get }
    func loadFirstInput() -> [String]
    func loadSecondInput() -> [String]
    func printSolution()
    func solveFirstQuiz()
    func solveSecondQuiz()
}

extension Day {
    var basePath: String {
        "/Users/lachermeier/Projects/AoC22/AoC22/Day\(day)/"
    }
    
    var pathToFirstInput: String {
        basePath + "input1.txt"
    }
    
    var pathToSecondInput: String {
        basePath + "input2.txt"
    }
    
    func loadFirstInput() -> [String] {
        FileHelper.readFileToStringArray(path: pathToFirstInput)
    }
    
    func loadSecondInput() -> [String] {
        FileHelper.readFileToStringArray(path: pathToSecondInput)
    }
    
    func printSolution() {
        print("-------------------------")
        print("Day \(day)")
        print("*: ", terminator: "")
        solveFirstQuiz()
        
        print("**: ", terminator: "")
        solveSecondQuiz()
    }
}
