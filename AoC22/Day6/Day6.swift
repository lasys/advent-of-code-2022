//
//  Day6.swift
//  AoC22
//
//  Created by Tobias Lachermeier on 06.12.22.
//

import Foundation

class Day6: Day {
    var day: Int = 6
    
    func solveFirstQuiz() {
        let counter = solve(maxNumberOfElements: 4)
        let solution = "\(counter)"
        print(solution)
    }
    
    func solveSecondQuiz() {
        let counter = solve(maxNumberOfElements: 14)
        let solution = "\(counter)"
        print(solution)
    }
    
    private func solve(maxNumberOfElements: Int) -> Int {
        let input = loadFirstInput()
        let line = input[0]
        var counter = 0
        var chars = [String]()
        var markers = [String: Int]()
        for c in Array(line) {
            let char = String(c)
            
            counter += 1
            
            if chars.count < maxNumberOfElements {
                chars.append(char)
                continue
            }
            
            if chars.count == maxNumberOfElements {
                chars.removeFirst()
            }
            
            chars.append(char)
            markers = [String: Int]()
            var isUnique = true
            for cc in chars {
                if markers[cc] == nil {
                    markers[cc] = 1
                } else {
                    isUnique = false
                    break
                }
            }
            
            if isUnique {
                break
            }
        
        }
        
        return counter
    }
}
