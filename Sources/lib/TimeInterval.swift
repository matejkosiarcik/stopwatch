//
// TimeInterval.swift
// Copyright © 2017 Matej Kosiarcik. All rights reserved.
//

import Foundation

extension TimeInterval {
    public var formatted: String {
        let interval = Int(self * 1000)

        let miliSeconds = interval % 1000
        let seconds = (interval / 1000) % 60
        let minutes = (interval / 1000 / 60) % 60
        let hours = (interval / 1000 / 60 / 60)

        return String(NSString(format: "%0.2d:%0.2d:%0.2d.%0.3d", hours, minutes, seconds, miliSeconds))
    }
}
