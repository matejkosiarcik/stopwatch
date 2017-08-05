//
// This file is part of Stopwatch which is released under MIT license.
// See file LICENSE.txt or go to https://github.com/matejkosiarcik/Stopwatch for full license details.
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
