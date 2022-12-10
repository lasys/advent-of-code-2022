//
//  Day7.swift
//  AoC22
//
//  Created by Tobias Lachermeier on 06.12.22.
//

import Foundation

struct File {
    let name: String
    let size: Int
    
    init(_ string: String) {
        let split = string.split(separator: " ")
        name = String(split[1])
        size = Int(split[0]) ?? 0
    }
}

class Directory {
    let name: String
    var size: Int {
        directories.reduce(0, { res, dir in res + dir.size })
        + files.reduce(0, { res, file in res + file.size })
    }
    var directories = [Directory]()
    var files = [File]()
    var parent: Directory?
    
    init(_ string: String, parent: Directory? = nil) {
        self.name = String(string.split(separator: " ")[1])
        self.parent = parent
    }
    
    func cd(_ to: String) -> Directory? {
        return directories.first(where: { $0.name == to })
    }
    
    func cdToParent() -> Directory? {
        return parent
    }
    
    func list(_ string: String) {
        if string.starts(with: "dir") {
            directories.append(Directory(string, parent: self))
        } else {
            files.append(File(string))
        }
    }
    
    func sumSize() -> Int {
        let s = size
        var crr = 0
        if s <= 100_000 {
            crr = s
        }
        for d in directories {
            let sum = d.sumSize()
            crr += sum
        }
        
        return crr
    }
    
    func fitsBestForDeleting(current: Int, threshold: Int) -> Int {
        let s = size
        var crr = current
        if s < current && threshold < s {
            crr = s
        }
        
        for d in directories {
            crr = d.fitsBestForDeleting(current: crr, threshold: threshold)
        }
        
        return crr
    }
}

class Day7: Day {
    var day: Int = 7
    
    func solveFirstQuiz() {
        var input = loadFirstInput()
        input.removeFirst()
        let rootDirectory: Directory = Directory("dir /")
        var currentDirectory = rootDirectory
        for line in input {
            if line.starts(with: "$") {
                if line.starts(with: "$ cd") {
                    let split = line.split(separator: " ")
                    switch String(split[2]) {
                    case "..":
                        currentDirectory = currentDirectory.cdToParent()!
                    case "/":
                        currentDirectory = rootDirectory
                    default:
                        currentDirectory = currentDirectory.cd(String(split[2]))!
                    }
                }
            } else {
                
                currentDirectory.list(line)
            }
        }
        
        let solution = rootDirectory.sumSize()
        print(solution)
    }
    
    func solveSecondQuiz() {
        var input = loadFirstInput()
        input.removeFirst()
        let rootDirectory: Directory = Directory("dir /")
        var currentDirectory = rootDirectory
        for line in input {
            if line.starts(with: "$") {
                if line.starts(with: "$ cd") {
                    let split = line.split(separator: " ")
                    switch String(split[2]) {
                    case "..":
                        currentDirectory = currentDirectory.cdToParent()!
                    case "/":
                        currentDirectory = rootDirectory
                    default:
                        currentDirectory = currentDirectory.cd(String(split[2]))!
                    }
                }
            } else {
                
                currentDirectory.list(line)
            }
        }
        
        let totalSize = rootDirectory.size
        let unused = (70000000 - totalSize)
        let threshold = 30000000 - unused
        let solution = rootDirectory.fitsBestForDeleting(current: 30000000, threshold: threshold)
        print(solution)
    }
}
