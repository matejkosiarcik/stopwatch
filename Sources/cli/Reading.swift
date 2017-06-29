//
// Reading.swift
// Copyright © 2017 Matej Kosiarcik. All rights reserved.
//

import Foundation

public func readCharacter(from file: FileHandle) -> Character? {
    let data = file.readData(ofLength: 1)
    let string = String(data: data, encoding: .ascii)
    return string?.characters.first
}
