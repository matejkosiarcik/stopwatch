//
// main.swift
// Copyright © 2017 Matej Kosiarcik. All rights reserved.
//

import cli
import Foundation
import lib

extension Character {
    static let esc = Character("\u{1B}")
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

func report(time: String) {
    print(time, terminator: "\r")
    fflush(stdout) // force terminal to print message; because when buffered it can wait till \n is printed
}

func updateInfo(for timer: lib.Timer) {
    shell("clear")
    timer.laps.map { $0.formatted }.forEach { print($0) }
    report(time: timer.current.formatted)
}

func main() {
    setupStandardInput()
    var timer = lib.Timer()

    func reportLoop() {
        report(time: timer.current.formatted)
        DispatchQueue.global(qos: .userInteractive).asyncAfter(deadline: .now() + 0.005) { reportLoop() }
    }
    reportLoop()

    timer.start()
    loop: while true {
        guard let input = readCharacter(from: .standardInput) else { continue }
        if input == .esc { break loop }
        else if input == Character(" ") { timer.status == .stopped ? timer.start() : timer.stop() }
        else if input == Character("\r") || input == Character("\n") { timer.lap() }
        updateInfo(for: timer)
    }
    timer.lap()
    timer.stop()
    updateInfo(for: timer)
}

main()
