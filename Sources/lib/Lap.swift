//
// Lap.swift
// Copyright © 2017 Matej Kosiarcik. All rights reserved.
//

import Foundation

extension Timer {
    public struct Lap {
        public var absolute: TimeInterval
        public var relative: TimeInterval
    }
}

extension Timer.Lap: Equatable {
    public static func == (lhs: Timer.Lap, rhs: Timer.Lap) -> Bool {
        guard lhs.absolute == rhs.absolute else { return false }
        guard lhs.relative == rhs.relative else { return false }
        return true
    }
}
