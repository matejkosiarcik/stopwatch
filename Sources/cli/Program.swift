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
        while true {
            guard let input = readCharacter(from: .standardInput) else { continue }
            if input.isStop { break }
            else if input.isPause { timer.toggle() }
            else if input.isLap { timer.lap() }
            self.update(laps: timer.laps)
        }
        timer.lap()
        timer.stop()
        self.update(laps: timer.laps)
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
    func update(laps: [lib.Timer.Lap]) {
        _ = shell("clear")
        print(laps.formatted)
    }
}

// swiftlint:disable:next no_extension_access_modifier
private extension Character {
    var isPause: Bool { return self == Character(" ") }
    var isLap: Bool { return self == Character("\r") || self == Character("\n") }
    var isStop: Bool { return self == Character("\u{1B}") } // esc
}
