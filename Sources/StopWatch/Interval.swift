//
// Interval.swift
// Copyright © 2017 Matej Kosiarcik. All rights reserved.
//

import Foundation

public struct Interval {
    public let cumulative: TimeInterval
    public let lapped: TimeInterval

    public init (cumulative: TimeInterval, lapped: TimeInterval) {
        self.cumulative = cumulative
        self.lapped = lapped
    }
}

extension Interval: Equatable {
    public static func == (lhs: Interval, rhs: Interval) -> Bool {
        return lhs.cumulative == rhs.cumulative && lhs.lapped == rhs.lapped
    }
}
