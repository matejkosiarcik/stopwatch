//
// Program.swift
// Copyright © 2017 Matej Kosiarcik. All rights reserved.
//

import Foundation
import lib
import Result

public struct Program {
    let arguments: Arguments
}

extension Program {
    public typealias Error = Arguments.Error
    public typealias ExitCode = Int32
}

extension Program {
    public static func new(for arguments: [String]) -> Result<Program, Program.Error> {
        return Arguments.new(from: arguments).map { Program(arguments: $0) }
    }
}

extension Program {
    public func main() -> ExitCode {
        if self.arguments.help {
            print(self.help())
        } else if self.arguments.version {
            print(self.version())
        } else {
            type(of: self).setUp()
            self.runStopWatch()
        }
        return 0
    }

    private func runStopWatch() {
        var timer = lib.Timer()

        func reportLoop() {
            print(line: timer.current.formatted)
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
}

extension Program {
    func help() -> String {
        return self.arguments.usage
    }

    func version() -> String {
        return """
        StopWatch - CLI stopwatch application
        version: 0.1.0
        """
    }
}

extension Program {
    private static func setUp() {
        // setup *unbuffered* standard input
        setbuf(stdin, nil)
        setvbuf(stdin, nil, _IONBF, 0)
        var input = termios()
        tcgetattr(STDIN_FILENO, &input)
        input.c_lflag = tcflag_t(Int32(input.c_lflag) & ~ICANON)
        tcsetattr(STDIN_FILENO, TCSANOW, &input)
    }
}

private func print(line: String = "") {
    print(line, terminator: "\r")
    fflush(stdout) // force terminal to print message; because when buffered it can wait till \n is printed
}

private func updateInfo(for timer: lib.Timer) {
    shell("clear")
    timer.laps.map { $0.formatted }.forEach { print($0) }
    print(line: timer.current.formatted)
}

private extension Character {
    static let esc = Character("\u{1B}")
}
