//
// main.swift
// Copyright © 2017 Matej Kosiarcik. All rights reserved.
//

import Foundation
import StopWatch

extension Character {
    static let esc = Character("\u{1B}")
}

extension TimeInterval {
    var formatted: String {
        let interval = Int(self * 1000)

        let miliSeconds = interval % 1000
        let seconds = (interval / 1000) % 60
        let minutes = (interval / 1000 / 60) % 60
        let hours = (interval / 1000 / 60 / 60)

        return String(NSString(format: "%0.2d:%0.2d:%0.2d.%0.3d", hours, minutes, seconds, miliSeconds))
    }
}

@discardableResult
func shell(_ command: String) -> Int32 {
    let task = Process()
    task.launchPath = "/bin/sh"
    task.arguments = ["-c"] + [command]
    task.launch()
    task.waitUntilExit()
    return task.terminationStatus
}

func readCharacter(from file: FileHandle) -> Character? {
    let data = file.readData(ofLength: 1)
    let string = String(data: data, encoding: .ascii)
    return string?.characters.first
}

// setup unbuffered standard input
func setupStandardInput() {
    setbuf(stdin, nil)
    setvbuf(stdin, nil, _IONBF, 0)
    var input = termios()
    tcgetattr(STDIN_FILENO, &input)
    input.c_lflag = tcflag_t(Int32(input.c_lflag) & ~ICANON)
    tcsetattr(STDIN_FILENO, TCSANOW, &input)
}

func main() {
    setupStandardInput()
    let watcher = Watcher(each: 0.005) { print(abs($0.cumulative).formatted, terminator: "\r"); fflush(stdout) }
    watcher.start()
    loop: while true {
        guard let input = readCharacter(from: .standardInput) else { continue }
        shell("clear")
        if input == .esc { break loop }
    }
}

main()
