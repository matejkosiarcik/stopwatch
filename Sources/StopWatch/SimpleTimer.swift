//
// SimpleTimer.swift
// Copyright © 2017 Matej Kosiarcik. All rights reserved.
//

import Foundation

public final class SimpleTimer {
    private let onUpdate: (TimeInterval) -> Void
    private let updateInterval: TimeInterval
    private var isActive = false
    private var startDate = Date.distantPast

    // MARK: De/Init
    public init(each interval: TimeInterval, onUpdate: @escaping (TimeInterval) -> Void) {
        self.updateInterval = interval
        self.onUpdate = onUpdate
    }

    deinit {
        self.stop()
    }
}

// MARK: - Updating
extension SimpleTimer {
    private func update() {
        guard self.isActive else { return }
        let interval = self.startDate.timeIntervalSince(Date())
        self.onUpdate(interval)
        DispatchQueue.global(qos: .userInteractive).asyncAfter(deadline: .now() + self.updateInterval) { self.update() }
    }
}

// MARK: - Start/Stop
extension SimpleTimer {
    public func start() {
        self.isActive = true
        self.startDate = Date()
        self.update()
    }

    @discardableResult
    public func stop() -> TimeInterval {
        self.isActive = false
        return self.startDate.timeIntervalSince(Date())
    }
}
