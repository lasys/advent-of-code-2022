//
//  Day9.swift
//  AoC22
//
//  Created by Tobias Lachermeier on 11.12.22.
//

import Foundation

class Day9: Day {
    var day: Int = 9
    
    class Coordinate: Hashable, Equatable {
        var x: Int
        var y: Int
        
        init(x: Int, y: Int) {
            self.x = x
            self.y = y
        }
        
        func hash(into hasher: inout Hasher) {
            hasher.combine(x)
            hasher.combine(y)
        }
       
        static func == (lhs: Day9.Coordinate, rhs: Day9.Coordinate) -> Bool {
            return lhs.x == rhs.x && lhs.y == rhs.y
        }
        
        func copy() -> Coordinate {
            return Coordinate(x: x, y: y)
        }
    }
    
    class Snake {
        var positions = Set<Coordinate>()
        var coordinates: [Coordinate]
        
        init(positions: Set<Coordinate> = Set<Coordinate>(), coordinates: [Coordinate]) {
            self.positions = positions
            self.coordinates = coordinates
        }
        
        func getNearest(current: Coordinate, previous: Coordinate, direction: String) -> Coordinate {
            var temp = previous.copy()
            
            // rechts / links
            if current.y == previous.y && current.x != previous.x {
                temp = previous.copy()
                temp.x += 1
                if tailIsAround(head: current, tail: temp) { return temp }
                
                temp = previous.copy()
                temp.x -= 1
                if tailIsAround(head: current, tail: temp) { return temp }
            }
            
            // oben/unten
            if current.y != previous.y && current.x == previous.x {
                temp = previous.copy()
                temp.y += 1
                if tailIsAround(head: current, tail: temp) { return temp }
                
                temp = previous.copy()
                temp.y -= 1
                if tailIsAround(head: current, tail: temp) { return temp }
            }
            
            // diago
            if current.y != previous.y && current.x != previous.x {
                temp = previous.copy()
                temp.y += 1
                temp.x += 1
                if tailIsAround(head: current, tail: temp) { return temp }
                
                temp = previous.copy()
                temp.y -= 1
                temp.x -= 1
                if tailIsAround(head: current, tail: temp) { return temp }
                
                temp = previous.copy()
                temp.y += 1
                temp.x -= 1
                if tailIsAround(head: current, tail: temp) { return temp }
                
                temp = previous.copy()
                temp.y -= 1
                temp.x += 1
                if tailIsAround(head: current, tail: temp) { return temp }
            }
            
            return temp
        }
        
        
        func up(steps: Int) {
            for _ in 0..<steps {
                coordinates[0].y -= 1
                
                for i in 0..<coordinates.count - 1 {
                    if tailIsAround(head: coordinates[i], tail: coordinates[i+1]) == false {
                        coordinates[i+1] = getNearest(current: coordinates[i], previous: coordinates[i+1], direction: "U").copy()
                    }
                    
                    if i == coordinates.count - 2 {
                        positions.insert(coordinates.last!.copy())
                    }
                }
            }
        }
        
        func right(steps: Int) {
            for _ in 0..<steps {
                coordinates[0].x += 1
                for i in 0..<coordinates.count - 1 {
                    if tailIsAround(head: coordinates[i], tail: coordinates[i+1]) == false {
                        coordinates[i+1] = getNearest(current: coordinates[i], previous: coordinates[i+1], direction: "R").copy()
                    }
                    
                    if i == coordinates.count - 2 {
                        positions.insert(coordinates.last!.copy())
                    }
                }
            }
        }
        
        
        func down(steps: Int) {
            for _ in 0..<steps {
                coordinates[0].y += 1
                for i in 0..<coordinates.count - 1 {
                    if tailIsAround(head: coordinates[i], tail: coordinates[i+1]) == false {
                        coordinates[i+1] = getNearest(current: coordinates[i], previous: coordinates[i+1], direction: "D").copy()
                    }
                    
                    if i == coordinates.count - 2 {
                        positions.insert(coordinates.last!.copy())
                    }
                }
            }
        }
        
        func left(steps: Int) {
            for _ in 0..<steps {
                coordinates[0].x -= 1
                for i in 0..<coordinates.count - 1 {
                    if tailIsAround(head: coordinates[i], tail: coordinates[i+1]) == false {
                        coordinates[i+1] = getNearest(current: coordinates[i], previous: coordinates[i+1], direction: "L").copy()
                    }
                    
                    if i == coordinates.count - 2 {
                        positions.insert(coordinates.last!.copy())
                    }
                }
            }

        }
        
        func tailIsAround(head: Coordinate, tail: Coordinate) -> Bool {
            return (head.x == tail.x && head.y == tail.y) ||
                   (head.x == tail.x - 1 && head.y == tail.y) ||
                   (head.x == tail.x + 1 && head.y == tail.y) ||
                   (head.x == tail.x && head.y == tail.y - 1) ||
                   (head.x == tail.x && head.y == tail.y + 1) ||
                   (head.x == tail.x + 1 && head.y == tail.y + 1) ||
                   (head.x == tail.x - 1 && head.y == tail.y - 1) ||
                   (head.x == tail.x + 1 && head.y == tail.y - 1) ||
                   (head.x == tail.x - 1 && head.y == tail.y + 1)
        }
        
        func printToConsole() {
            
            let numberOfRows = 15
            let numberOfCols = 15
            
            print()
            for col in -numberOfRows..<numberOfRows {
                for row in -numberOfRows..<numberOfCols {
                    if row == 0 && col == 0 {
                        print("S", terminator: "")
                        continue
                    }
                    var text: String?
                    
                    for i in 0..<positions.count {
                        let coordinate = Array(positions)[i]
                        if coordinate.x == row && coordinate.y == col {
                            text = "#"
                        }
                    }
                    
                    for i in 0..<coordinates.count {
                        let coordinate = coordinates[i]
                        if coordinate.x == row && coordinate.y == col {
                            text = String(i)
                        }
                    }
                    
                    if let text {
                        print(text, terminator: "")
                    } else {
                        print(".", terminator: "")
                    }
                }
                print()
            }
            print()
        }
    }
    
    
    func solveFirstQuiz() {
        let input = loadFirstInput()
        let snake = Snake(coordinates:  [Coordinate(x: 0, y: 0),
                                         Coordinate(x: 0, y: 0)])
        snake.positions.insert(Coordinate(x: 0, y: 0))
        
        for line in input {
            let split = line.split(separator: " ")
            let direction = String(split[0])
            
            guard let steps = Int(String(split[1])) else { continue }
            
            switch direction {
            case "U": snake.up(steps: steps)
            case "R": snake.right(steps: steps)
            case "D": snake.down(steps: steps)
            case "L": snake.left(steps: steps)
            default: print(direction)
            }
        }
       
        let solution = "\(snake.positions.count)"
        print(solution)
    }
    
    func solveSecondQuiz() {
        let input = loadFirstInput()
        let snake = Snake(coordinates: [Coordinate(x: 0, y: 0),
                                         Coordinate(x: 0, y: 0),
                                         Coordinate(x: 0, y: 0),
                                         Coordinate(x: 0, y: 0),
                                         Coordinate(x: 0, y: 0),
                                         Coordinate(x: 0, y: 0),
                                         Coordinate(x: 0, y: 0),
                                         Coordinate(x: 0, y: 0),
                                         Coordinate(x: 0, y: 0),
                                         Coordinate(x: 0, y: 0)])
        snake.positions.insert(Coordinate(x: 0, y: 0))
        
        for line in input {
            let split = line.split(separator: " ")
            let direction = String(split[0])
            
            guard let steps = Int(String(split[1])) else { continue }
            
            switch direction {
            case "U": snake.up(steps: steps)
            case "R": snake.right(steps: steps)
            case "D": snake.down(steps: steps)
            case "L": snake.left(steps: steps)
            default: print(direction)
            }
        }
       
        let solution = "\(snake.positions.count)"
        print(solution)
    }
}
