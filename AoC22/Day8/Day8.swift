//
//  Day8.swift
//  AoC22
//
//  Created by Tobias Lachermeier on 07.12.22.
//

import Foundation

struct Coordinate {
    let x: Int
    let y: Int
}

class Matrix {
    var rows: Int {
        elements.first?.count ?? 0
    }
    
    var columns: Int {
        elements.count
    }
    
    var elements = [[Int]]()
    
    func append(element: Int, at column: Int) {
        if elements.count == column + 1 {
            elements[column].append(element)
        } else {
            elements.append([element])
        }
    }
    
    func removeBorder() {
        elements.removeFirst()
        elements.removeLast()
        
        for i in 0..<elements.count {
            elements[i].removeLast()
            elements[i].removeFirst()
        }
    }
    
    func element(at coordinate: Coordinate) -> Int? {
        return element(at: coordinate.x, and: coordinate.y)
    }
    
    func element(at x: Int, and y: Int) -> Int? {
        
        if elements.count < y + 1 || y + 1 < 1 {
            return nil
        }
        
        if elements[y].count < x + 1 || x + 1 < 1 {
            return nil
        }
        
        return elements[y][x]
    }
    
    func printToConsole() {
        print()
        for element in elements {
            for e in element {
                print(e, terminator: " ")
            }
            print()
        }
    }
    
    func countTrees(crr: Int, x: Int, y: Int, dx: Int, dy: Int) -> Int {
        var tempX = x
        var tempY = y
        var counter = 0
        while true {
            guard let element = element(at: tempX + dx, and: tempY + dy) else { return counter }
            if crr <= element {
                counter += 1
                return counter
            }
            tempY += dy
            tempX += dx
            counter += 1
        }
    }
    
    func check(crr: Int, x: Int, y: Int, dx: Int, dy: Int) -> Bool? {
        var tempX = x
        var tempY = y
        while true {
            guard let element = element(at: tempX + dx, and: tempY + dy) else { return true }
            if crr <= element {
                return nil
            }
            tempY += dy
            tempX += dx
        }
    }
}



class Day8: Day {
    var day: Int = 8
    
    func solveFirstQuiz() {
        let matrix = Matrix()
        let input = loadFirstInput()
        var counter = 0
        for line in input {
            for l in Array(line) {
                let element = Int(String(l))!
                matrix.append(element: element, at: counter)
            }
            counter += 1
        }
        
        let numberOfEdges = matrix.rows * 2 + matrix.columns * 2 - 4

        counter = 0
        for x in 1..<matrix.rows - 1 {
            for y in 1..<matrix.columns - 1  {
                guard let crr = matrix.element(at: x, and: y) else { continue }
                
                if matrix.check(crr: crr, x: x, y: y, dx: 0, dy: -1) != nil {
                    counter += 1
                    continue
                }
                
                if matrix.check(crr: crr, x: x, y: y, dx: 0, dy: +1) != nil {
                    counter += 1
                    continue
                }
                
                if matrix.check(crr: crr, x: x, y: y, dx: 1, dy: 0) != nil {
                    counter += 1
                    continue
                }
                
                if matrix.check(crr: crr, x: x, y: y, dx: -1, dy: 0) != nil {
                    counter += 1
                    continue
                }
            }
        }
                
        let numberOfVisibleTrees = counter

        let solution = "\(numberOfEdges + numberOfVisibleTrees)"
        print(solution)
    }
    
    func solveSecondQuiz() {
        let matrix = Matrix()
        let input = loadFirstInput()
        var counter = 0
        for line in input {
            for l in Array(line) {
                let element = Int(String(l))!
                matrix.append(element: element, at: counter)
            }
            counter += 1
        }
        
        var maxScore = 0
        counter = 1
        for x in 1..<matrix.rows - 1 {
            for y in 1..<matrix.columns - 1  {
                counter = 1
                guard let crr = matrix.element(at: x, and: y) else { continue }
                
                counter *=  matrix.countTrees(crr: crr, x: x, y: y, dx: 0, dy: -1)
                
                counter *= matrix.countTrees(crr: crr, x: x, y: y, dx: 0, dy: +1)

                counter *= matrix.countTrees(crr: crr, x: x, y: y, dx: 1, dy: 0)
                
                counter *= matrix.countTrees(crr: crr, x: x, y: y, dx: -1, dy: 0)

                if maxScore < counter  {
                    maxScore = counter
                }
            }
        }
        
        let solution = "\(maxScore)"
        print(solution)
    }
}
