//
// This file is part of Stopwatch which is released under MIT license.
// See file LICENSE.txt or go to https://github.com/matejkosiarcik/Stopwatch for full license details.
//

import Foundation

public struct Timer {
    private var state = State.stopped
    private var cumulative: TimeInterval = 0
    private var sinceLastLap: TimeInterval = 0

    public init() {}
}

extension Timer {
    private var current: TimeInterval {
        switch self.state {
        case .running(let start):
            return abs(start.timeIntervalSinceNow)
        case .stopped:
            return 0
        }
    }

    public var progress: Interval {
        let current = self.current
        return Interval(absolute: self.cumulative + current, relative: self.sinceLastLap + current)
    }
}

extension Timer {
    public mutating func start() {
        switch self.state {
        case .stopped: self.state = .running(Date())
        default: break // do not start when already running
        }
    }

    public mutating func stop() {
        switch self.state {
        case .running(let start):
            let interval = abs(start.timeIntervalSinceNow)
            self.sinceLastLap += interval
            self.cumulative += interval
            self.state = .stopped
        default: break // do not stop when already stopped
        }
    }

    public mutating func toggle() {
        switch self.state {
        case .running: self.stop()
        case .stopped: self.start()
        }
    }

    public mutating func lap() {
        switch self.state {
        case .running:
            self.stop()
            self.sinceLastLap = 0
            self.start()
        default:
            self.sinceLastLap = 0
        }
    }
}

extension Timer {
    public enum State {
        case running(Date)
        case stopped
    }
}

extension Timer.State: Equatable {
    public static func == (lhs: Timer.State, rhs: Timer.State) -> Bool {
        switch (lhs, rhs) {
        case (.running(let x), .running(let y)): return x == y
        case (.stopped, .stopped): return true
        default: return false
        }
    }
}
