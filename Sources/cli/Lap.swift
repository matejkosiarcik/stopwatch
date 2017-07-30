//
// Lap.swift
// Copyright © 2017 Matej Kosiarcik. All rights reserved.
//

import lib

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
