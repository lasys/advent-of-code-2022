//
//  Day3.swift
//  AoC22
//
//  Created by Tobias Lachermeier on 06.12.22.
//

import Foundation

class Day3: Day {
    var day: Int = 3
    
    func solveFirstQuiz() {
        let input = loadFirstInput()
        var scores = 0
        for line in input {
            let half: Int = line.count / 2
            let firstHalf = Array(line)[0..<half]
            let secondHalf = Array(line)[half..<line.count]
            var score: Int?
            
            for h in firstHalf {
                if secondHalf.contains(h), let ascii = h.asciiValue {
                    if h.isLowercase {
                        score = Int(ascii) - 96
                    } else {
                        score = (Int(ascii) - 64) + 26
                    }
                    break
                }
            }
            
            if score == nil {
                for h in secondHalf {
                    if firstHalf.contains(h), let ascii = h.asciiValue {
                        if h.isLowercase {
                            score = Int(ascii) - 96
                        } else {
                            score = (Int(ascii) - 64) + 26
                        }
                        break
                    }
                }
            }
            
            if let score {
                scores += score
            }
            
            
            
        }
        let solution = "\(scores)"
        print(solution)
    }
    
    func solveSecondQuiz() {
        let input = loadFirstInput()
        var scores = 0
        
        var strings = [String]()
        
        for line in input {
            
            if strings.count < 3 {
                strings.append(line)
            }
            
            if strings.count != 3 {
                continue
            }
            
            let first = Array(strings[0])
            let second = Array(strings[1])
            let third = Array(strings[2])
            var score: Int?
            

            for h in first {
                if second.contains(h), third.contains(h), let ascii = h.asciiValue {
                    if h.isLowercase {
                        score = Int(ascii) - 96
                    } else {
                        score = (Int(ascii) - 64) + 26
                    }
                    break
                }
            }
            
            for h in second {
                if first.contains(h), third.contains(h), let ascii = h.asciiValue {
                    if h.isLowercase {
                        score = Int(ascii) - 96
                    } else {
                        score = (Int(ascii) - 64) + 26
                    }
                    break
                }
            }
            
            for h in third {
                if first.contains(h), second.contains(h), let ascii = h.asciiValue {
                    if h.isLowercase {
                        score = Int(ascii) - 96
                    } else {
                        score = (Int(ascii) - 64) + 26
                    }
                    break
                }
            }
    
            if let score {
                scores += score
            }
            
            
            strings.removeAll()
            
        }
        let solution = "\(scores)"
        print(solution)
    }
}
