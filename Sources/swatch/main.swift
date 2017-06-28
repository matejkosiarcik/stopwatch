//
// main.swift
// Copyright © 2017 Matej Kosiarcik. All rights reserved.
//

import Foundation
import StopWatch

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

func main() {
    setupStandardInput()
    var timer = StopWatch.Timer()

    func report() {
        print(timer.current.formatted, terminator: "\r")
        fflush(stdout)
        DispatchQueue.global(qos: .userInteractive).asyncAfter(deadline: .now() + 0.05) { report() }
    }
    report()

    timer.start()
    loop: while true {
        guard let input = readCharacter(from: .standardInput) else { continue }
        shell("clear")
        if input == .esc { break loop }
        else if input == Character(" ") { timer.status == .stopped ? timer.start() : timer.stop() }
        else if input == Character("\r") || input == Character("\n") { timer.lap() }
    }
    timer.stop()
}

main()
