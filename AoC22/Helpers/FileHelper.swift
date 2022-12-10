//
//  FileHelper.swift
//  AoC22
//
//  Created by Tobias Lachermeier on 06.12.22.
//

import Foundation

class FileHelper {
    static func readFileToStringArray(path: String) -> [String] {
        var strings = [String]()
        guard let file = freopen(path, "r", stdin) else {
            return strings
        }
        defer {
            fclose(file)
        }

        while let line = readLine() {
            strings.append(line)
        }
        
        return strings
    }
}
