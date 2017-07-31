//
// Helpers.swift
// Copyright © 2017 Matej Kosiarcik. All rights reserved.
//

import Foundation

// reads single character from given file
public func readCharacter(from file: FileHandle) -> Character? {
    let data = file.readData(ofLength: 1)
    let string = String(data: data, encoding: .ascii)
    return string?.characters.first
}

// execute command in posix shell
public func shell(_ command: String) -> Int32 {
    let task = Process()
    task.launchPath = "/bin/sh"
    task.arguments = ["-c"] + [command]
    task.launch()
    task.waitUntilExit()
    return task.terminationStatus
}

// prints message and immediatelly flushes buffer for given file
// forces terminal to print message; because when buffered it can wait till \n is printed
func flushPrint(_ string: String, to file: UnsafeMutablePointer<FILE>) {
    let line = string + "\r"
    let chars = line.data(using: .utf8).map { $0.map { Int32($0) } } ?? []
    chars.forEach { fputc($0, file) }
    fflush(file)
}
