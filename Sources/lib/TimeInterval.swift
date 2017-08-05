//
// This file is part of Stopwatch which is released under MIT license.
// See file LICENSE.txt or go to https://github.com/matejkosiarcik/Stopwatch for full license details.
//

import Foundation

extension TimeInterval {
    public var formatted: String {
        let interval = Int(self * 1_000)

        let miliSeconds = interval % 1_000
        let seconds = (interval / 1_000) % 60
        let minutes = (interval / 1_000 / 60) % 60
        let hours = (interval / 1_000 / 60 / 60)

        return String(NSString(format: "%0.2d:%0.2d:%0.2d.%0.3d", hours, minutes, seconds, miliSeconds))
    }
}
