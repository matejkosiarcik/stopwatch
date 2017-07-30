//
// Lap.swift
// Copyright © 2017 Matej Kosiarcik. All rights reserved.
//

import Foundation

extension Timer {
    public struct Lap {
        public var absolute: TimeInterval // time from the very start
        public var relative: TimeInterval // time from last lap
    }
}

extension Timer.Lap: Equatable {
    public static func == (lhs: Timer.Lap, rhs: Timer.Lap) -> Bool {
        guard lhs.absolute == rhs.absolute else { return false }
        guard lhs.relative == rhs.relative else { return false }
        return true
    }
}

extension Timer.Lap {
    public var formatted: String {
        if self.absolute == self.relative { return "\(self.absolute.formatted) : -" }
        return "\(self.absolute.formatted) : \(self.relative.formatted)"
    }
}

extension Array where Element == Timer.Lap {
    public var formatted: String {
        return self.map { $0.formatted }.joined(separator: "\n")
    }
}
