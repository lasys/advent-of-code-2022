//
//  Day5.swift
//  AoC22
//
//  Created by Tobias Lachermeier on 06.12.22.
//

import Foundation

class Day5: Day {
    
    // https://medium.com/devslopes-blog/swift-data-structures-stack-4f301e4fa0dc
    struct Stack {
        private var items: [String] = []
        
        init(items: [String]) {
            self.items = items
        }
        
        func peek() -> String? {
            return items.first
        }
        
        mutating func pop() -> String? {
            guard items.isEmpty == false else { return nil }
            return items.removeFirst()
        }
        
        mutating func multiPop(count: Int) -> [String] {
            var elements = [String]()
            guard items.isEmpty == false else { return elements }
            for _ in 0..<count {
                if let popped = pop() {
                    elements.append(popped)
                }
            }
            return elements
        }
      
        mutating func push(_ element: String?) {
            guard let element else { return }
            items.insert(element, at: 0)
        }
        
        mutating func multiPush(_ elements: [String]) {
            let temp = elements + items
            items = temp
        }
    }
    
    struct Command {
        let count: Int
        let source: Int
        let destination: Int
        
        init(string: String) { // move 1 from 3 to 5
            let split = string
                .trimmingCharacters(in: .whitespacesAndNewlines)
                .split(separator: " ")
            count = Int(split[1]) ?? -1
            source = (Int(split[3]) ?? -1) - 1
            destination = (Int(split[5]) ?? -1) - 1
        }
    }
    
    var day: Int = 5
    
    
    func solveFirstQuiz() {
        let input = loadFirstInput()
        
        var stacks = [
            Stack(items: ["G","W","L","J","B","R","T","D"]),
            Stack(items: ["C","W","S"]),
            Stack(items: ["M","T","Z","R"]),
            Stack(items: ["V","P","S","H","C","T","D"]),
            Stack(items: ["Z","D","L","T","P","G"]),
            Stack(items: ["D","C","Q","J","Z","R","B","F"]),
            Stack(items: ["R","T","F","M","J","D","B","S"]),
            Stack(items: ["M","V","T","B","R","H","L"]),
            Stack(items: ["V","S","D","P","Q"]),
        ]
        
        for line in input {
            guard line.starts(with: "move") else { continue }
            let command = Command(string: line)
            for _ in 0..<command.count {
                stacks[command.destination].push(stacks[command.source].pop())
            }
        }
        
        let solution = stacks.map { $0.peek() ?? "" }.joined()
        print(solution)
    }
    
    func solveSecondQuiz() {
        let input = loadFirstInput()
        
        var stacks = [
            Stack(items: ["G","W","L","J","B","R","T","D"]),
            Stack(items: ["C","W","S"]),
            Stack(items: ["M","T","Z","R"]),
            Stack(items: ["V","P","S","H","C","T","D"]),
            Stack(items: ["Z","D","L","T","P","G"]),
            Stack(items: ["D","C","Q","J","Z","R","B","F"]),
            Stack(items: ["R","T","F","M","J","D","B","S"]),
            Stack(items: ["M","V","T","B","R","H","L"]),
            Stack(items: ["V","S","D","P","Q"]),
        ]
        
        for line in input {
            guard line.starts(with: "move") else { continue }
            let command = Command(string: line)
            stacks[command.destination].multiPush(stacks[command.source].multiPop(count:command.count))
        }
        
        let solution = stacks.map { $0.peek() ?? "" }.joined()
        print(solution)
    }
}
