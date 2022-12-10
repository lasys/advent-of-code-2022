//
//  Day4.swift
//  AoC22
//
//  Created by Tobias Lachermeier on 06.12.22.
//

import Foundation

struct Range {
    let start: Int
    let end: Int
    
    init(_ string: String) {
        let split = string.split(separator: "-")
        start = Int(split[0])!
        end = Int(split[1])!
    }
    
    func contains(_ range: Range) -> Bool {
        return start <= range.start && range.end <= end
    }
    
    func overlap(_ range: Range) -> Bool {
        return start <= range.start && range.start <= end ||
               start <= range.end && range.end <= end
    }
}

class Day4: Day {
    var day: Int = 4
    
    func solveFirstQuiz() {
        let input = loadFirstInput()
        var counts = 0
        for line in input {
            let split = line.split(separator: ",")
            let first = Range(String(split[0]))
            let second = Range(String(split[1]))
            if first.contains(second) {
                counts += 1
            }
            else if second.contains(first) {
                counts += 1
            }
        }
        
        let solution = "\(counts)"
        print(solution)
    }
    
    func solveSecondQuiz() {
        let input = loadFirstInput()
        var counts = 0
        for line in input {
            let split = line.split(separator: ",")
            let first = Range(String(split[0]))
            let second = Range(String(split[1]))
            if first.contains(second) {
                counts += 1
            }
            else if second.contains(first) {
                counts += 1
            } else if first.overlap(second) {
                counts += 1
            } else if second.overlap(first) {
                counts += 1
            }
        }
        
        let solution = "\(counts)"
        print(solution)
    }
}
