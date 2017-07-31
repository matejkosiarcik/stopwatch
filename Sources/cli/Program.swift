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
    public func main(output: inout String) -> ExitCode {
        if self.arguments.help {
            print(self.help(), to: &output)
        } else if self.arguments.version {
            print(self.version(), to: &output)
        } else {
            // TODO: change type(of: ) to Self, after SE-0068 is implemented
            type(of: self).setUp()
            self.runStopWatch()
        }
        return 0
    }

    private func runStopWatch() {
        var timer = lib.Timer()

        func reportLoop() {
            flushPrint(timer.current.formatted, to: stdout)
            DispatchQueue.global(qos: .userInteractive).asyncAfter(deadline: .now() + 0.005) { reportLoop() }
        }
        reportLoop()

        timer.start()
        loop: while true {
            guard let input = readCharacter(from: .standardInput) else { continue }
            if input == .esc { break loop }
            else if input == Character(" ") { timer.status == .stopped ? timer.start() : timer.stop() }
            else if input == Character("\r") || input == Character("\n") { timer.lap() }
            self.updateLaps(for: timer)
        }
        timer.lap()
        timer.stop()
        self.updateLaps(for: timer)
    }
}

extension Program {
    private func help() -> String {
        return self.arguments.usage
    }

    private func version() -> String {
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

// swiftlint:disable:next no_extension_access_modifier
private extension Program {
    func updateLaps(for timer: lib.Timer) {
        _ = shell("clear")
        print(timer.laps.formatted)
    }
}

// swiftlint:disable:next no_extension_access_modifier
private extension Character {
    static let esc = Character("\u{1B}")
}
