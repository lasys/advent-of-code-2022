//
//  Day10.swift
//  AoC22
//
//  Created by Tobias Lachermeier on 10.12.22.
//

import Foundation

class Day10: Day {
    var day: Int = 10
    
    class CPU {
        var X: Int = 1
        var cycle: Int = 0
        var sum: Int = 0
        
        var crts = [[String]]()
        var crrCrt = [String]()
        var crtIndex = 0
        
        func draw() {
            let rowIndex = (cycle % 40) - 1
            
            if rowIndex == crtIndex || rowIndex == crtIndex + 1 || rowIndex == crtIndex + 2  {
                crrCrt.append("#")
            } else {
                crrCrt.append(".")
            }
            
            if rowIndex == -1 {
                if crrCrt.count != 0 {
                    // fix last element on each row
                    crrCrt.removeLast()
                    crrCrt.append(".")
                    // fix ^^
                    
                    crts.append(crrCrt)
                    crrCrt = [String]()
                }
            }
        }
        
        func noop() {
            cycle += 1
            checkCycle()
        }
        
        func add(v: Int) {
            cycle += 1
            checkCycle()
            cycle += 1
            checkCycle()
            X += v
            crtIndex = X - 1
        }
        
        func checkCycle() {
            switch cycle {
            case 20, 60, 100, 140, 180, 220:
                sum += X * cycle
            default: break
            }
            
            draw()
        }
    }
    
    func solveFirstQuiz() {
        let input = loadFirstInput()
        let cpu = CPU()
        for line in input {
            if line == "noop" {
                cpu.noop()
            }
            
            else if line.starts(with: "addx") {
                if let v = Int(String(line.split(separator: " ")[1])) {
                    cpu.add(v: v)
                } else {
                    print("unknown: \(line)")
                }
            } else {
                print("unknown: \(line)")
            }
        }
        
        let solution = "\(cpu.sum)"
        print(solution)
    }
    
    func solveSecondQuiz() {
        let input = loadFirstInput()
        let cpu = CPU()
        for line in input {
            if line == "noop" {
                cpu.noop()
            }
            
            else if line.starts(with: "addx") {
                if let v = Int(String(line.split(separator: " ")[1])) {
                    cpu.add(v: v)
                } else {
                    print("unknown: \(line)")
                }
            } else {
                print("unknown: \(line)")
            }
        }
        print()
        for crt in cpu.crts {
            print(crt.joined(separator: ""))
        }
        print("RGZEHURK")
    }
}
