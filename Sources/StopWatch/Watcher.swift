//
// Watcher.swift
// Copyright © 2017 Matej Kosiarcik. All rights reserved.
//

import Foundation

public final class Watcher {
    private let onUpdate: (Interval) -> Void
    private var laps = [Date]()
    private var isActive = false
    private let updateInterval: TimeInterval

    // MARK: De/Init
    public init(each interval: TimeInterval = 0.001, onUpdate: @escaping (Interval) -> Void) {
        self.onUpdate = onUpdate
        self.updateInterval = interval
    }

    deinit {
        self.stop()
    }
}

// MARK: - Updating
extension Watcher {
    private func update(timer: Timer) {
        guard self.isActive else { timer.invalidate(); return }
        let current = Date()
        let interval = Interval(cumulative: self.laps.first!.timeIntervalSince(current),
                                lapped: self.laps.last!.timeIntervalSince(current))
        self.onUpdate(interval)
    }
}

// MARK: - Start/Stop
extension Watcher {
    public func start() {
        self.laps.append(Date())
        self.isActive = true
        _ = Timer.scheduledTimer(withTimeInterval: self.updateInterval, repeats: true, block: self.update)
    }

    public func stop() {
        self.isActive = false
    }
}
