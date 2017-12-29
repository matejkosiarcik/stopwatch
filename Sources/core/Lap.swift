//
// This file is part of Stopwatch which is released under MIT license.
// See file LICENSE.txt or go to https://github.com/matejkosiarcik/Stopwatch for full license details.
//

import Foundation

extension Timer {
    public struct Interval {
        public var absolute: TimeInterval // time from the very start
        public var relative: TimeInterval // time from last lap
    }
}

extension Timer.Interval: Equatable {
    public static func == (lhs: Timer.Interval, rhs: Timer.Interval) -> Bool {
        guard lhs.absolute == rhs.absolute else { return false }
        guard lhs.relative == rhs.relative else { return false }
        return true
    }
}

extension Timer.Interval {
    public var formatted: String {
        return "\(self.absolute.formatted) : \(self.relative.formatted)"
    }
}
